import '../local/database.dart';
import '../remote/exam_api.dart';

/// Coordinates the local cache with the remote PTS/PAS endpoints.
class ExamRepository {
  ExamRepository(this._db, this._api, this.kind);

  final AppDatabase _db;
  final ExamApi _api;
  final String kind;

  AppDatabase get db => _db;

  /// Pulls exam rows + scores of [kind] into the local cache.
  Future<void> refreshExams() async {
    final raw = await _api.exams();
    final exams = <ServerExam>[];
    final scores = <ServerExamScore>[];

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
      exams.add(
        ServerExam(
          id: id,
          classId: _asInt(map['class_id']),
          className: klass is Map ? klass['name']?.toString() : null,
          title: map['title']?.toString() ?? '-',
          examDate: _asDate(map['exam_date']),
          description: map['description']?.toString(),
        ),
      );

      final rawScores = map['scores'];
      if (rawScores is List) {
        for (final s in rawScores) {
          if (s is! Map) {
            continue;
          }
          final sm = s.cast<String, dynamic>();
          final sid = _asInt(sm['id']);
          final studentId = _asInt(sm['student_id']);
          final score = _asDouble(sm['score']);
          if (sid == null || studentId == null || score == null) {
            continue;
          }
          scores.add(
            ServerExamScore(
              id: sid,
              examRemoteId: id,
              studentId: studentId,
              score: score,
            ),
          );
        }
      }
    }

    await _db.mergeExamRecords(kind, exams);
    await _db.mergeExamScores(kind, scores);
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

  static double? _asDouble(dynamic value) {
    if (value is num) {
      return value.toDouble();
    }
    return double.tryParse(value?.toString() ?? '');
  }

  static DateTime? _asDate(dynamic value) {
    if (value == null) {
      return null;
    }
    return DateTime.tryParse(value.toString());
  }
}
