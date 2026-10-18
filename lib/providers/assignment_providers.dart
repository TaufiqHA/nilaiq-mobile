import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../data/local/database.dart';
import 'infrastructure_providers.dart';
import 'sync_provider.dart';

/// Live list of assignment meetings from the local cache.
final assignmentMeetingsProvider =
    StreamProvider<List<AssignmentMeetingRecord>>(
      (ref) => ref.watch(databaseProvider).watchAssignmentMeetings(),
    );

/// Live score records for a given local assignment meeting id.
final assignmentScoresProvider =
    StreamProvider.family<List<AssignmentScoreRecord>, int>(
      (ref, meetingLocalId) => ref
          .watch(databaseProvider)
          .watchAssignmentScoresForMeeting(meetingLocalId),
    );

final assignmentActionsProvider = Provider<AssignmentActions>(
  AssignmentActions.new,
);

/// Write operations for the assignment feature. All writes hit the local
/// database first, then attempt a background sync.
class AssignmentActions {
  AssignmentActions(this._ref);

  final Ref _ref;
  static const _uuid = Uuid();

  AppDatabase get _db => _ref.read(databaseProvider);

  Future<void> refresh() => _ref.read(syncControllerProvider.notifier).sync();

  void _sync() => unawaited(_ref.read(syncControllerProvider.notifier).sync());

  Future<void> createMeeting({
    int? classId,
    String? className,
    required String title,
    DateTime? assignmentDate,
    String? description,
  }) async {
    await _db.createAssignmentMeetingLocally(
      clientUuid: _uuid.v4(),
      classId: classId,
      className: className,
      title: title,
      assignmentDate: assignmentDate,
      description: description,
    );
    _sync();
  }

  Future<void> updateMeeting(
    AssignmentMeetingRecord meeting, {
    int? classId,
    String? className,
    required String title,
    DateTime? assignmentDate,
    String? description,
  }) async {
    await _db.updateAssignmentMeetingLocally(
      meeting,
      classId: classId,
      className: className,
      title: title,
      assignmentDate: assignmentDate,
      description: description,
    );
    _sync();
  }

  Future<void> deleteMeeting(AssignmentMeetingRecord meeting) async {
    await _db.deleteAssignmentMeetingLocally(meeting);
    _sync();
  }

  Future<void> saveScore({
    required AssignmentMeetingRecord meeting,
    required int studentId,
    required double score,
  }) async {
    await _db.saveAssignmentScoreLocally(
      meeting: meeting,
      studentId: studentId,
      score: score,
    );
    _sync();
  }
}
