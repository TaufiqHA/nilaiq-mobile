import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../data/local/database.dart';
import 'infrastructure_providers.dart';
import 'sync_provider.dart';

/// Live list of meetings from the local cache.
final meetingsProvider = StreamProvider<List<MeetingRecord>>(
  (ref) => ref.watch(databaseProvider).watchMeetings(),
);

/// Live list of classes from the local cache.
final classesProvider = StreamProvider<List<CachedClass>>(
  (ref) => ref.watch(databaseProvider).watchClasses(),
);

/// Live attendance records for a given local meeting id.
final meetingAttendancesProvider =
    StreamProvider.family<List<AttendanceRecord>, int>(
      (ref, meetingLocalId) => ref
          .watch(databaseProvider)
          .watchAttendancesForMeeting(meetingLocalId),
    );

/// Live students for a given class id.
final classStudentsProvider = StreamProvider.family<List<CachedStudent>, int>(
  (ref, classId) => ref.watch(databaseProvider).watchStudentsForClass(classId),
);

final absensiActionsProvider = Provider<AbsensiActions>(AbsensiActions.new);

/// Write operations for the absensi feature. All writes hit the local
/// database first, then attempt a background sync.
class AbsensiActions {
  AbsensiActions(this._ref);

  final Ref _ref;
  static const _uuid = Uuid();

  AppDatabase get _db => _ref.read(databaseProvider);

  Future<void> refresh() => _ref.read(syncControllerProvider.notifier).sync();

  void _sync() => unawaited(_ref.read(syncControllerProvider.notifier).sync());

  Future<void> createMeeting({
    int? classId,
    String? className,
    required String title,
    required String tipe,
    DateTime? meetingDate,
    String? description,
  }) async {
    await _db.createMeetingLocally(
      clientUuid: _uuid.v4(),
      classId: classId,
      className: className,
      title: title,
      tipe: tipe,
      meetingDate: meetingDate,
      description: description,
    );
    _sync();
  }

  Future<void> updateMeeting(
    MeetingRecord meeting, {
    int? classId,
    String? className,
    required String title,
    required String tipe,
    DateTime? meetingDate,
    String? description,
  }) async {
    await _db.updateMeetingLocally(
      meeting,
      classId: classId,
      className: className,
      title: title,
      tipe: tipe,
      meetingDate: meetingDate,
      description: description,
    );
    _sync();
  }

  Future<void> deleteMeeting(MeetingRecord meeting) async {
    await _db.deleteMeetingLocally(meeting);
    _sync();
  }

  Future<void> saveAttendance({
    required MeetingRecord meeting,
    required int studentId,
    required String status,
    String? note,
  }) async {
    await _db.saveAttendanceLocally(
      meeting: meeting,
      studentId: studentId,
      status: status,
      note: note,
    );
    _sync();
  }
}
