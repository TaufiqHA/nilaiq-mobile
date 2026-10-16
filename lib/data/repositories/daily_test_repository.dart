import '../local/database.dart';
import '../remote/daily_test_api.dart';

/// Coordinates the local cache with the remote daily test endpoints.
class DailyTestRepository {
  DailyTestRepository(this._db, this._api);

  final AppDatabase _db;
  final DailyTestApi _api;

  AppDatabase get db => _db;

  /// Pulls daily test meetings + scores into the local cache.
  Future<void> refreshDailyTests() async {
    final raw = await _api.meetings();
    final meetings = <ServerDailyTestMeeting>[];
    final scores = <ServerDailyTestScore>[];

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
        ServerDailyTestMeeting(
          id: id,
          classId: _asInt(map['class_id']),
          className: klass is Map ? klass['name']?.toString() : null,
          title: map['title']?.toString() ?? '-',
          testDate: _asDate(map['test_date']),
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
          final meetingId = _asInt(sm['daily_test_meeting_id']);
          final studentId = _asInt(sm['student_id']);
          final score = _asDouble(sm['score']);
          if (sid == null ||
              meetingId == null ||
              studentId == null ||
              score == null) {
            continue;
          }
          scores.add(
            ServerDailyTestScore(
              id: sid,
              meetingRemoteId: meetingId,
              studentId: studentId,
              score: score,
            ),
          );
        }
      }
    }

    await _db.mergeDailyTestMeetings(meetings);
    await _db.mergeDailyTestScores(scores);
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
