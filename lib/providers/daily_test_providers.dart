import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../data/local/database.dart';
import 'infrastructure_providers.dart';
import 'sync_provider.dart';

/// Live list of daily test meetings from the local cache.
final dailyTestMeetingsProvider = StreamProvider<List<DailyTestMeetingRecord>>(
  (ref) => ref.watch(databaseProvider).watchDailyTestMeetings(),
);

/// Live score records for a given local daily test meeting id.
final dailyTestScoresProvider =
    StreamProvider.family<List<DailyTestScoreRecord>, int>(
      (ref, meetingLocalId) => ref
          .watch(databaseProvider)
          .watchDailyTestScoresForMeeting(meetingLocalId),
    );

final dailyTestActionsProvider = Provider<DailyTestActions>(
  DailyTestActions.new,
);

/// Write operations for the daily test feature. All writes hit the local
/// database first, then attempt a background sync.
class DailyTestActions {
  DailyTestActions(this._ref);

  final Ref _ref;
  static const _uuid = Uuid();

  AppDatabase get _db => _ref.read(databaseProvider);

  Future<void> refresh() => _ref.read(syncControllerProvider.notifier).sync();

  void _sync() => unawaited(_ref.read(syncControllerProvider.notifier).sync());

  Future<void> createMeeting({
    int? classId,
    String? className,
    required String title,
    DateTime? testDate,
    String? description,
  }) async {
    await _db.createDailyTestMeetingLocally(
      clientUuid: _uuid.v4(),
      classId: classId,
      className: className,
      title: title,
      testDate: testDate,
      description: description,
    );
    _sync();
  }

  Future<void> updateMeeting(
    DailyTestMeetingRecord meeting, {
    int? classId,
    String? className,
    required String title,
    DateTime? testDate,
    String? description,
  }) async {
    await _db.updateDailyTestMeetingLocally(
      meeting,
      classId: classId,
      className: className,
      title: title,
      testDate: testDate,
      description: description,
    );
    _sync();
  }

  Future<void> deleteMeeting(DailyTestMeetingRecord meeting) async {
    await _db.deleteDailyTestMeetingLocally(meeting);
    _sync();
  }

  Future<void> saveScore({
    required DailyTestMeetingRecord meeting,
    required int studentId,
    required double score,
  }) async {
    await _db.saveDailyTestScoreLocally(
      meeting: meeting,
      studentId: studentId,
      score: score,
    );
    _sync();
  }
}
