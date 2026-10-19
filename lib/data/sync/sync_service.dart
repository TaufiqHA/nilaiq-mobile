import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import '../../core/api_exception.dart';
import '../../core/connectivity_service.dart';
import '../local/database.dart';
import '../remote/absensi_api.dart';
import '../remote/assignment_api.dart';
import '../remote/daily_test_api.dart';
import '../remote/exam_api.dart';
import '../repositories/absensi_repository.dart';
import '../repositories/assignment_repository.dart';
import '../repositories/daily_test_repository.dart';
import '../repositories/exam_repository.dart';

class SyncResult {
  const SyncResult({
    required this.online,
    this.pushed = 0,
    this.failed = 0,
    this.message,
  });

  final bool online;
  final int pushed;
  final int failed;
  final String? message;

  bool get success => online && failed == 0;
  bool get hasWork => pushed > 0 || failed > 0;
}

/// Pushes queued offline operations to the server, then refreshes the cache.
class SyncService {
  SyncService(
    this._db,
    this._api,
    this._repository,
    this._connectivity,
    this._dailyTestApi,
    this._dailyTestRepository,
    this._assignmentApi,
    this._assignmentRepository,
    this._midtermExamApi,
    this._midtermExamRepository,
    this._finalExamApi,
    this._finalExamRepository,
  );

  final AppDatabase _db;
  final AbsensiApi _api;
  final AbsensiRepository _repository;
  final ConnectivityService _connectivity;
  final DailyTestApi _dailyTestApi;
  final DailyTestRepository _dailyTestRepository;
  final AssignmentApi _assignmentApi;
  final AssignmentRepository _assignmentRepository;
  final ExamApi _midtermExamApi;
  final ExamRepository _midtermExamRepository;
  final ExamApi _finalExamApi;
  final ExamRepository _finalExamRepository;

  static final _dateFormat = DateFormat('yyyy-MM-dd');
  static const _uuid = Uuid();
  static final _uuidPattern = RegExp(
    r'^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$',
  );

  Future<SyncResult> synchronize() async {
    try {
      return await _synchronize();
    } on ApiException catch (e) {
      return SyncResult(online: true, failed: 1, message: e.message);
    } catch (e) {
      return SyncResult(
        online: true,
        failed: 1,
        message: 'Sinkronisasi gagal: $e',
      );
    }
  }

  Future<SyncResult> _synchronize() async {
    if (!await _isOnline()) {
      return const SyncResult(
        online: false,
        message: 'Tidak ada koneksi internet.',
      );
    }

    // Collapse duplicate attendance rows (a server may store several rows for
    // the same meeting/student, which otherwise breaks lookups).
    try {
      await _db.dedupeAttendances();
    } catch (_) {}
    try {
      await _db.dedupeDailyTestScores();
    } catch (_) {}
    try {
      await _db.dedupeAssignmentScores();
    } catch (_) {}
    try {
      await _db.dedupeExamScores();
    } catch (_) {}

    var pushed = 0;
    var failed = 0;
    String? message;
    var guard = 0;

    while (guard++ < 500) {
      final ops = await _db.pendingOperationsOrdered();
      if (ops.isEmpty) {
        break;
      }
      final op = ops.first;
      try {
        final handled = await _process(op);
        if (!handled) {
          failed++;
          break;
        }
        await _db.removePendingOperation(op.id);
        pushed++;
      } on ApiException catch (e) {
        await _db.markPendingFailure(op.id, e.message);
        failed++;
        message = e.message;
        break;
      } catch (e) {
        await _db.markPendingFailure(op.id, e.toString());
        failed++;
        message = 'Terjadi kesalahan saat sinkronisasi.';
        break;
      }
    }

    // Best-effort cache refresh (keeps offline-created rows untouched).
    try {
      await _repository.refreshClasses().timeout(const Duration(seconds: 30));
    } catch (_) {}
    try {
      await _repository.refreshMeetings().timeout(const Duration(seconds: 30));
    } catch (_) {}
    try {
      await _dailyTestRepository.refreshDailyTests().timeout(
        const Duration(seconds: 30),
      );
    } catch (_) {}
    try {
      await _assignmentRepository.refreshAssignments().timeout(
        const Duration(seconds: 30),
      );
    } catch (_) {}
    try {
      await _midtermExamRepository.refreshExams().timeout(
        const Duration(seconds: 30),
      );
    } catch (_) {}
    try {
      await _finalExamRepository.refreshExams().timeout(
        const Duration(seconds: 30),
      );
    } catch (_) {}

    return SyncResult(
      online: true,
      pushed: pushed,
      failed: failed,
      message: message,
    );
  }

  Future<bool> _isOnline() async {
    try {
      return await _connectivity.isOnline().timeout(
        const Duration(seconds: 10),
      );
    } catch (_) {
      // If the connectivity plugin is unavailable, let the requests decide.
      return true;
    }
  }

  Future<bool> _process(PendingOperation op) async {
    switch ('${op.entity}/${op.operation}') {
      case 'meeting/create':
        return _createMeeting(op);
      case 'meeting/update':
        return _updateMeeting(op);
      case 'meeting/delete':
        return _deleteRemote(op, (id) => _api.deleteMeeting(id));
      case 'attendance/create':
        return _createAttendance(op);
      case 'attendance/update':
        return _updateAttendance(op);
      case 'attendance/delete':
        return _deleteRemote(op, (id) => _api.deleteAttendance(id));
      case 'daily_test_meeting/create':
        return _createDailyTestMeeting(op);
      case 'daily_test_meeting/update':
        return _updateDailyTestMeeting(op);
      case 'daily_test_meeting/delete':
        return _deleteRemote(op, (id) => _dailyTestApi.deleteMeeting(id));
      case 'daily_test_score/create':
        return _createDailyTestScore(op);
      case 'daily_test_score/update':
        return _updateDailyTestScore(op);
      case 'daily_test_score/delete':
        return _deleteRemote(op, (id) => _dailyTestApi.deleteScore(id));
      case 'assignment_meeting/create':
        return _createAssignmentMeeting(op);
      case 'assignment_meeting/update':
        return _updateAssignmentMeeting(op);
      case 'assignment_meeting/delete':
        return _deleteRemote(op, (id) => _assignmentApi.deleteMeeting(id));
      case 'assignment_score/create':
        return _createAssignmentScore(op);
      case 'assignment_score/update':
        return _updateAssignmentScore(op);
      case 'assignment_score/delete':
        return _deleteRemote(op, (id) => _assignmentApi.deleteScore(id));
      case 'midterm_exam/create':
        return _createExam(op, examKindMidterm);
      case 'midterm_exam/update':
        return _updateExam(op, examKindMidterm);
      case 'midterm_exam/delete':
        return _deleteRemote(op, (id) => _midtermExamApi.deleteExam(id));
      case 'midterm_score/create':
        return _createExamScore(op, examKindMidterm);
      case 'midterm_score/update':
        return _updateExamScore(op, examKindMidterm);
      case 'midterm_score/delete':
        return _deleteRemote(op, (id) => _midtermExamApi.deleteScore(id));
      case 'final_exam/create':
        return _createExam(op, examKindFinal);
      case 'final_exam/update':
        return _updateExam(op, examKindFinal);
      case 'final_exam/delete':
        return _deleteRemote(op, (id) => _finalExamApi.deleteExam(id));
      case 'final_score/create':
        return _createExamScore(op, examKindFinal);
      case 'final_score/update':
        return _updateExamScore(op, examKindFinal);
      case 'final_score/delete':
        return _deleteRemote(op, (id) => _finalExamApi.deleteScore(id));
      default:
        return true;
    }
  }

  Future<bool> _createMeeting(PendingOperation op) async {
    final meeting = await _db.meetingByLocalId(op.localId);
    if (meeting == null) {
      return true;
    }

    final res = await _api.createMeeting({
      'client_uuid': meeting.clientUuid,
      'class_id': meeting.classId,
      'title': meeting.title,
      'tipe': meeting.tipe,
      'meeting_date': meeting.meetingDate == null
          ? null
          : _dateFormat.format(meeting.meetingDate!),
      'description': meeting.description,
    });

    final data = _dataOf(res);
    final remoteId = data['id'];
    if (remoteId is! int) {
      throw ApiException(
        'Server tidak mengembalikan ID pertemuan. Data belum tersimpan.',
      );
    }
    await _db.markMeetingSynced(meeting.localId, remoteId: remoteId);
    await _db.enqueueAttendanceCreatesForMeeting(meeting.localId);
    return true;
  }

  Future<bool> _updateMeeting(PendingOperation op) async {
    final meeting = await _db.meetingByLocalId(op.localId);
    if (meeting == null) {
      return true;
    }
    if (meeting.remoteId == null) {
      return false;
    }

    await _api.updateMeeting(meeting.remoteId!, {
      'class_id': meeting.classId,
      'title': meeting.title,
      'tipe': meeting.tipe,
      'meeting_date': meeting.meetingDate == null
          ? null
          : _dateFormat.format(meeting.meetingDate!),
      'description': meeting.description,
    });
    await _db.markMeetingSynced(meeting.localId);
    return true;
  }

  Future<bool> _createAttendance(PendingOperation op) async {
    final attendance = await _db.attendanceByLocalId(op.localId);
    if (attendance == null) {
      return true;
    }
    final meeting = await _db.meetingByLocalId(attendance.meetingLocalId);
    if (meeting?.remoteId == null) {
      // Meeting must be created first; it will be retried afterwards.
      return false;
    }

    // Heal rows created before client UUIDs were generated correctly.
    var clientUuid = attendance.clientUuid;
    if (!_uuidPattern.hasMatch(clientUuid)) {
      clientUuid = _uuid.v4();
      await _db.setAttendanceClientUuid(attendance.localId, clientUuid);
    }

    final res = await _api.saveAttendance({
      'client_uuid': clientUuid,
      'attendance_meeting_id': meeting!.remoteId,
      'student_id': attendance.studentId,
      'status': attendance.status,
      'note': attendance.note,
    });

    final data = _dataOf(res);
    final remoteId = data['id'];
    if (remoteId is! int) {
      throw ApiException(
        'Server tidak mengembalikan ID absensi. Data belum tersimpan.',
      );
    }
    await _db.markAttendanceSynced(attendance.localId, remoteId: remoteId);
    return true;
  }

  Future<bool> _updateAttendance(PendingOperation op) async {
    final attendance = await _db.attendanceByLocalId(op.localId);
    if (attendance == null) {
      return true;
    }
    if (attendance.remoteId == null) {
      return false;
    }
    final meeting = await _db.meetingByLocalId(attendance.meetingLocalId);
    if (meeting?.remoteId == null) {
      return false;
    }

    // The server re-validates the full payload on update, so the meeting and
    // student ids must be included (not just the changed fields).
    await _api.updateAttendance(attendance.remoteId!, {
      'attendance_meeting_id': meeting!.remoteId,
      'student_id': attendance.studentId,
      'status': attendance.status,
      'note': attendance.note,
    });
    await _db.markAttendanceSynced(attendance.localId);
    return true;
  }

  Future<bool> _createDailyTestMeeting(PendingOperation op) async {
    final meeting = await _db.dailyTestMeetingByLocalId(op.localId);
    if (meeting == null) {
      return true;
    }

    final res = await _dailyTestApi.createMeeting({
      'client_uuid': meeting.clientUuid,
      'class_id': meeting.classId,
      'title': meeting.title,
      'test_date': meeting.testDate == null
          ? null
          : _dateFormat.format(meeting.testDate!),
      'description': meeting.description,
    });

    final data = _dataOf(res);
    final remoteId = data['id'];
    if (remoteId is! int) {
      throw ApiException(
        'Server tidak mengembalikan ID ulangan. Data belum tersimpan.',
      );
    }
    await _db.markDailyTestMeetingSynced(meeting.localId, remoteId: remoteId);
    await _db.enqueueDailyTestScoreCreatesForMeeting(meeting.localId);
    return true;
  }

  Future<bool> _updateDailyTestMeeting(PendingOperation op) async {
    final meeting = await _db.dailyTestMeetingByLocalId(op.localId);
    if (meeting == null) {
      return true;
    }
    if (meeting.remoteId == null) {
      return false;
    }

    await _dailyTestApi.updateMeeting(meeting.remoteId!, {
      'class_id': meeting.classId,
      'title': meeting.title,
      'test_date': meeting.testDate == null
          ? null
          : _dateFormat.format(meeting.testDate!),
      'description': meeting.description,
    });
    await _db.markDailyTestMeetingSynced(meeting.localId);
    return true;
  }

  Future<bool> _createDailyTestScore(PendingOperation op) async {
    final score = await _db.dailyTestScoreByLocalId(op.localId);
    if (score == null) {
      return true;
    }
    final meeting = await _db.dailyTestMeetingByLocalId(score.meetingLocalId);
    if (meeting?.remoteId == null) {
      // Meeting must be created first; it will be retried afterwards.
      return false;
    }

    // Heal rows created before client UUIDs were generated correctly.
    var clientUuid = score.clientUuid;
    if (!_uuidPattern.hasMatch(clientUuid)) {
      clientUuid = _uuid.v4();
      await _db.setDailyTestScoreClientUuid(score.localId, clientUuid);
    }

    final res = await _dailyTestApi.saveScore({
      'client_uuid': clientUuid,
      'daily_test_meeting_id': meeting!.remoteId,
      'student_id': score.studentId,
      'score': score.score,
    });

    final data = _dataOf(res);
    final remoteId = data['id'];
    if (remoteId is! int) {
      throw ApiException(
        'Server tidak mengembalikan ID nilai ulangan. Data belum tersimpan.',
      );
    }
    await _db.markDailyTestScoreSynced(score.localId, remoteId: remoteId);
    return true;
  }

  Future<bool> _updateDailyTestScore(PendingOperation op) async {
    final score = await _db.dailyTestScoreByLocalId(op.localId);
    if (score == null) {
      return true;
    }
    if (score.remoteId == null) {
      return false;
    }
    final meeting = await _db.dailyTestMeetingByLocalId(score.meetingLocalId);
    if (meeting?.remoteId == null) {
      return false;
    }

    await _dailyTestApi.updateScore(score.remoteId!, {
      'daily_test_meeting_id': meeting!.remoteId,
      'student_id': score.studentId,
      'score': score.score,
    });
    await _db.markDailyTestScoreSynced(score.localId);
    return true;
  }

  Future<bool> _createAssignmentMeeting(PendingOperation op) async {
    final meeting = await _db.assignmentMeetingByLocalId(op.localId);
    if (meeting == null) {
      return true;
    }

    final res = await _assignmentApi.createMeeting({
      'client_uuid': meeting.clientUuid,
      'class_id': meeting.classId,
      'title': meeting.title,
      'assignment_date': meeting.assignmentDate == null
          ? null
          : _dateFormat.format(meeting.assignmentDate!),
      'description': meeting.description,
    });

    final data = _dataOf(res);
    final remoteId = data['id'];
    if (remoteId is! int) {
      throw ApiException(
        'Server tidak mengembalikan ID tugas. Data belum tersimpan.',
      );
    }
    await _db.markAssignmentMeetingSynced(meeting.localId, remoteId: remoteId);
    await _db.enqueueAssignmentScoreCreatesForMeeting(meeting.localId);
    return true;
  }

  Future<bool> _updateAssignmentMeeting(PendingOperation op) async {
    final meeting = await _db.assignmentMeetingByLocalId(op.localId);
    if (meeting == null) {
      return true;
    }
    if (meeting.remoteId == null) {
      return false;
    }

    await _assignmentApi.updateMeeting(meeting.remoteId!, {
      'class_id': meeting.classId,
      'title': meeting.title,
      'assignment_date': meeting.assignmentDate == null
          ? null
          : _dateFormat.format(meeting.assignmentDate!),
      'description': meeting.description,
    });
    await _db.markAssignmentMeetingSynced(meeting.localId);
    return true;
  }

  Future<bool> _createAssignmentScore(PendingOperation op) async {
    final score = await _db.assignmentScoreByLocalId(op.localId);
    if (score == null) {
      return true;
    }
    final meeting = await _db.assignmentMeetingByLocalId(score.meetingLocalId);
    if (meeting?.remoteId == null) {
      // Meeting must be created first; it will be retried afterwards.
      return false;
    }

    // Heal rows created before client UUIDs were generated correctly.
    var clientUuid = score.clientUuid;
    if (!_uuidPattern.hasMatch(clientUuid)) {
      clientUuid = _uuid.v4();
      await _db.setAssignmentScoreClientUuid(score.localId, clientUuid);
    }

    final res = await _assignmentApi.saveScore({
      'client_uuid': clientUuid,
      'assignment_meeting_id': meeting!.remoteId,
      'student_id': score.studentId,
      'score': score.score,
    });

    final data = _dataOf(res);
    final remoteId = data['id'];
    if (remoteId is! int) {
      throw ApiException(
        'Server tidak mengembalikan ID nilai tugas. Data belum tersimpan.',
      );
    }
    await _db.markAssignmentScoreSynced(score.localId, remoteId: remoteId);
    return true;
  }

  Future<bool> _updateAssignmentScore(PendingOperation op) async {
    final score = await _db.assignmentScoreByLocalId(op.localId);
    if (score == null) {
      return true;
    }
    if (score.remoteId == null) {
      return false;
    }
    final meeting = await _db.assignmentMeetingByLocalId(score.meetingLocalId);
    if (meeting?.remoteId == null) {
      return false;
    }

    await _assignmentApi.updateScore(score.remoteId!, {
      'assignment_meeting_id': meeting!.remoteId,
      'student_id': score.studentId,
      'score': score.score,
    });
    await _db.markAssignmentScoreSynced(score.localId);
    return true;
  }

  ExamApi _examApi(String kind) =>
      kind == examKindFinal ? _finalExamApi : _midtermExamApi;

  String _examForeignKey(String kind) =>
      kind == examKindFinal ? 'final_exam_id' : 'midterm_exam_id';

  Future<bool> _createExam(PendingOperation op, String kind) async {
    final exam = await _db.examByLocalId(op.localId);
    if (exam == null) {
      return true;
    }

    final res = await _examApi(kind).createExam({
      'client_uuid': exam.clientUuid,
      'class_id': exam.classId,
      'title': exam.title,
      'exam_date': exam.examDate == null
          ? null
          : _dateFormat.format(exam.examDate!),
      'description': exam.description,
    });

    final data = _dataOf(res);
    final remoteId = data['id'];
    if (remoteId is! int) {
      throw ApiException(
        'Server tidak mengembalikan ID ujian. Data belum tersimpan.',
      );
    }
    await _db.markExamSynced(exam.localId, remoteId: remoteId);
    await _db.enqueueExamScoreCreatesForExam(exam.localId);
    return true;
  }

  Future<bool> _updateExam(PendingOperation op, String kind) async {
    final exam = await _db.examByLocalId(op.localId);
    if (exam == null) {
      return true;
    }
    if (exam.remoteId == null) {
      return false;
    }

    await _examApi(kind).updateExam(exam.remoteId!, {
      'class_id': exam.classId,
      'title': exam.title,
      'exam_date': exam.examDate == null
          ? null
          : _dateFormat.format(exam.examDate!),
      'description': exam.description,
    });
    await _db.markExamSynced(exam.localId);
    return true;
  }

  Future<bool> _createExamScore(PendingOperation op, String kind) async {
    final score = await _db.examScoreByLocalId(op.localId);
    if (score == null) {
      return true;
    }
    final exam = await _db.examByLocalId(score.examLocalId);
    if (exam?.remoteId == null) {
      // Exam must be created first; it will be retried afterwards.
      return false;
    }

    // Heal rows created before client UUIDs were generated correctly.
    var clientUuid = score.clientUuid;
    if (!_uuidPattern.hasMatch(clientUuid)) {
      clientUuid = _uuid.v4();
      await _db.setExamScoreClientUuid(score.localId, clientUuid);
    }

    final res = await _examApi(kind).saveScore({
      'client_uuid': clientUuid,
      _examForeignKey(kind): exam!.remoteId,
      'student_id': score.studentId,
      'score': score.score,
    });

    final data = _dataOf(res);
    final remoteId = data['id'];
    if (remoteId is! int) {
      throw ApiException(
        'Server tidak mengembalikan ID nilai ujian. Data belum tersimpan.',
      );
    }
    await _db.markExamScoreSynced(score.localId, remoteId: remoteId);
    return true;
  }

  Future<bool> _updateExamScore(PendingOperation op, String kind) async {
    final score = await _db.examScoreByLocalId(op.localId);
    if (score == null) {
      return true;
    }
    if (score.remoteId == null) {
      return false;
    }
    final exam = await _db.examByLocalId(score.examLocalId);
    if (exam?.remoteId == null) {
      return false;
    }

    await _examApi(kind).updateScore(score.remoteId!, {
      _examForeignKey(kind): exam!.remoteId,
      'student_id': score.studentId,
      'score': score.score,
    });
    await _db.markExamScoreSynced(score.localId);
    return true;
  }

  Future<bool> _deleteRemote(
    PendingOperation op,
    Future<void> Function(int remoteId) delete,
  ) async {
    final remoteId = _remoteIdFromPayload(op);
    if (remoteId != null) {
      await delete(remoteId);
    }
    return true;
  }

  Map<String, dynamic> _dataOf(Map<String, dynamic> response) {
    final data = response['data'];
    if (data is Map) {
      return data.cast<String, dynamic>();
    }
    return response;
  }

  int? _remoteIdFromPayload(PendingOperation op) {
    try {
      final decoded = jsonDecode(op.payload);
      if (decoded is Map && decoded['remote_id'] is int) {
        return decoded['remote_id'] as int;
      }
    } catch (_) {}
    return null;
  }
}
