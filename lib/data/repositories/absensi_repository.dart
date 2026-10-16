import '../local/database.dart';
import '../remote/absensi_api.dart';

/// Coordinates the local cache with the remote absensi endpoints.
class AbsensiRepository {
  AbsensiRepository(this._db, this._api);

  final AppDatabase _db;
  final AbsensiApi _api;

  AppDatabase get db => _db;

  /// Pulls classes + students into the local cache.
  Future<void> refreshClasses() async {
    final raw = await _api.classes();
    final classes = <({int id, String name})>[];
    final students =
        <({int id, int? classId, String name, String? nis, String? gender})>[];

    for (final item in raw) {
      if (item is! Map) {
        continue;
      }
      final map = item.cast<String, dynamic>();
      final id = _asInt(map['id']);
      if (id == null) {
        continue;
      }
      classes.add((id: id, name: map['name']?.toString() ?? '-'));

      final rawStudents = map['students'];
      if (rawStudents is List) {
        for (final s in rawStudents) {
          if (s is! Map) {
            continue;
          }
          final sm = s.cast<String, dynamic>();
          final sid = _asInt(sm['id']);
          if (sid == null) {
            continue;
          }
          students.add((
            id: sid,
            classId: _asInt(sm['class_id']) ?? id,
            name: sm['name']?.toString() ?? '-',
            nis: sm['nis']?.toString(),
            gender: sm['gender']?.toString(),
          ));
        }
      }
    }

    await _db.replaceClasses(classes, students);
  }

  /// Pulls meetings + attendances into the local cache.
  Future<void> refreshMeetings() async {
    final raw = await _api.meetings();
    final meetings = <ServerMeeting>[];
    final attendances = <ServerAttendance>[];

    for (final item in raw) {
      if (item is! Map) {
        continue;
      }
      final map = item.cast<String, dynamic>();
      final id = _asInt(map['id']);
      if (id == null) {
        continue;
      }
      final klass = map['class'];
      meetings.add(
        ServerMeeting(
          id: id,
          classId: _asInt(map['class_id']),
          className: klass is Map ? klass['name']?.toString() : null,
          title: map['title']?.toString() ?? '-',
          tipe: map['tipe']?.toString() ?? 'harian',
          meetingDate: _asDate(map['meeting_date']),
          description: map['description']?.toString(),
        ),
      );

      final rawAttendances = map['attendances'];
      if (rawAttendances is List) {
        for (final a in rawAttendances) {
          if (a is! Map) {
            continue;
          }
          final am = a.cast<String, dynamic>();
          final aid = _asInt(am['id']);
          final meetingId = _asInt(am['attendance_meeting_id']);
          final studentId = _asInt(am['student_id']);
          if (aid == null || meetingId == null || studentId == null) {
            continue;
          }
          attendances.add(
            ServerAttendance(
              id: aid,
              meetingRemoteId: meetingId,
              studentId: studentId,
              status: am['status']?.toString() ?? 'HADIR',
              note: am['note']?.toString(),
            ),
          );
        }
      }
    }

    await _db.mergeMeetings(meetings);
    await _db.mergeAttendances(attendances);
  }

  static int? _asInt(dynamic value) {
    if (value is int) {
      return value;
    }
    if (value is num) {
      return value.toInt();
    }
    return int.tryParse(value?.toString() ?? '');
  }

  static DateTime? _asDate(dynamic value) {
    if (value == null) {
      return null;
    }
    return DateTime.tryParse(value.toString());
  }
}
