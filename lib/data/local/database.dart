import 'dart:convert';
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

part 'database.g.dart';

/// Cached list of classes (read-only mirror of the server).
@DataClassName('CachedClass')
class CachedClasses extends Table {
  IntColumn get id => integer()();
  TextColumn get name => text()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Cached list of students belonging to a class.
class CachedStudents extends Table {
  IntColumn get id => integer()();
  IntColumn get classId => integer().nullable()();
  TextColumn get name => text()();
  TextColumn get nis => text().nullable()();
  TextColumn get gender => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Attendance meetings. Offline-created rows keep a local id until synced.
class MeetingRecords extends Table {
  IntColumn get localId => integer().autoIncrement()();
  IntColumn get remoteId => integer().nullable()();
  TextColumn get clientUuid => text()();
  IntColumn get classId => integer().nullable()();
  TextColumn get className => text().nullable()();
  TextColumn get title => text()();
  TextColumn get tipe => text().withDefault(const Constant('harian'))();
  DateTimeColumn get meetingDate => dateTime().nullable()();
  TextColumn get description => text().nullable()();
  TextColumn get syncStatus => text().withDefault(const Constant('synced'))();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

/// Attendance records per meeting/student.
class AttendanceRecords extends Table {
  IntColumn get localId => integer().autoIncrement()();
  IntColumn get remoteId => integer().nullable()();
  TextColumn get clientUuid => text()();
  IntColumn get meetingLocalId => integer()();
  IntColumn get studentId => integer()();
  TextColumn get status => text().withDefault(const Constant('HADIR'))();
  TextColumn get note => text().nullable()();
  TextColumn get syncStatus =>
      text().withDefault(const Constant('pending_create'))();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

/// Daily test (ulangan harian) meetings. Offline-created rows keep a local id
/// until synced.
class DailyTestMeetingRecords extends Table {
  IntColumn get localId => integer().autoIncrement()();
  IntColumn get remoteId => integer().nullable()();
  TextColumn get clientUuid => text()();
  IntColumn get classId => integer().nullable()();
  TextColumn get className => text().nullable()();
  TextColumn get title => text()();
  DateTimeColumn get testDate => dateTime().nullable()();
  TextColumn get description => text().nullable()();
  TextColumn get syncStatus => text().withDefault(const Constant('synced'))();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

/// Daily test scores per meeting/student.
class DailyTestScoreRecords extends Table {
  IntColumn get localId => integer().autoIncrement()();
  IntColumn get remoteId => integer().nullable()();
  TextColumn get clientUuid => text()();
  IntColumn get meetingLocalId => integer()();
  IntColumn get studentId => integer()();
  RealColumn get score => real()();
  TextColumn get syncStatus =>
      text().withDefault(const Constant('pending_create'))();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

/// Outbox queue of operations waiting to be pushed to the server.
class PendingOperations extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get entity => text()();
  IntColumn get localId => integer()();
  TextColumn get operation => text()();
  TextColumn get payload => text().withDefault(const Constant('{}'))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  IntColumn get attempts => integer().withDefault(const Constant(0))();
  TextColumn get lastError => text().nullable()();
}

/// Single-row cache of the dashboard payload.
class CachedDashboard extends Table {
  IntColumn get id => integer().withDefault(const Constant(1))();
  TextColumn get payload => text()();
  DateTimeColumn get fetchedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Simple key/value metadata store (last sync time, theme, etc).
class AppMeta extends Table {
  TextColumn get key => text()();
  TextColumn get value => text()();

  @override
  Set<Column> get primaryKey => {key};
}

@DriftDatabase(
  tables: [
    CachedClasses,
    CachedStudents,
    MeetingRecords,
    AttendanceRecords,
    DailyTestMeetingRecords,
    DailyTestScoreRecords,
    PendingOperations,
    CachedDashboard,
    AppMeta,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  AppDatabase.forTesting(super.executor);

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) => m.createAll(),
    onUpgrade: (m, from, to) async {
      if (from < 2) {
        await m.createTable(dailyTestMeetingRecords);
        await m.createTable(dailyTestScoreRecords);
      }
    },
  );

  // ---------------------------------------------------------------------------
  // Cache refresh
  // ---------------------------------------------------------------------------

  Future<void> replaceClasses(
    List<({int id, String name})> classes,
    List<({int id, int? classId, String name, String? nis, String? gender})>
    students,
  ) async {
    await batch((b) {
      b.deleteAll(cachedClasses);
      b.insertAllOnConflictUpdate(
        cachedClasses,
        classes
            .map(
              (c) =>
                  CachedClassesCompanion.insert(id: Value(c.id), name: c.name),
            )
            .toList(),
      );
      b.deleteAll(cachedStudents);
      b.insertAllOnConflictUpdate(
        cachedStudents,
        students
            .map(
              (s) => CachedStudentsCompanion.insert(
                id: Value(s.id),
                classId: Value(s.classId),
                name: s.name,
                nis: Value(s.nis),
                gender: Value(s.gender),
              ),
            )
            .toList(),
      );
    });
  }

  /// Merges the server meeting list, preserving offline-created rows.
  Future<void> mergeMeetings(List<ServerMeeting> meetings) async {
    await transaction(() async {
      final synced = await (select(
        meetingRecords,
      )..where((t) => t.syncStatus.equals('synced'))).get();
      final syncedByRemote = {for (final m in synced) m.remoteId: m};
      final seenRemote = <int>{};

      for (final m in meetings) {
        seenRemote.add(m.id);
        final existing = syncedByRemote[m.id];
        if (existing != null) {
          await (update(
            meetingRecords,
          )..where((t) => t.localId.equals(existing.localId))).write(
            MeetingRecordsCompanion(
              classId: Value(m.classId),
              className: Value(m.className),
              title: Value(m.title),
              tipe: Value(m.tipe),
              meetingDate: Value(m.meetingDate),
              description: Value(m.description),
              updatedAt: Value(DateTime.now()),
            ),
          );
        } else {
          await into(meetingRecords).insert(
            MeetingRecordsCompanion.insert(
              remoteId: Value(m.id),
              clientUuid: 'server-${m.id}',
              classId: Value(m.classId),
              className: Value(m.className),
              title: m.title,
              tipe: Value(m.tipe),
              meetingDate: Value(m.meetingDate),
              description: Value(m.description),
              syncStatus: const Value('synced'),
            ),
          );
        }
      }

      for (final m in synced) {
        if (m.remoteId != null && !seenRemote.contains(m.remoteId)) {
          await (delete(
            attendanceRecords,
          )..where((t) => t.meetingLocalId.equals(m.localId))).go();
          await (delete(
            meetingRecords,
          )..where((t) => t.localId.equals(m.localId))).go();
        }
      }
    });
  }

  /// Merges server attendance rows, preserving offline rows.
  ///
  /// Rows are matched by remote id, but also by (meeting, student) so that a
  /// server that returns duplicate rows (or an offline row that already exists)
  /// never creates a second local row for the same student.
  Future<void> mergeAttendances(List<ServerAttendance> attendances) async {
    await transaction(() async {
      final before = await select(attendanceRecords).get();
      final byRemote = <int, AttendanceRecord>{
        for (final r in before)
          if (r.remoteId != null) r.remoteId!: r,
      };
      final seenRemote = <int>{};

      for (final a in attendances) {
        final meetingLocalId = await _meetingLocalIdForRemote(
          a.meetingRemoteId,
        );
        if (meetingLocalId == null) {
          continue;
        }
        seenRemote.add(a.id);

        final tracked = byRemote[a.id];
        if (tracked != null) {
          if (tracked.syncStatus == 'synced') {
            await _writeServerAttendance(tracked.localId, meetingLocalId, a);
          }
          continue;
        }

        final samePair = await (select(attendanceRecords)..where(
              (t) =>
                  t.meetingLocalId.equals(meetingLocalId) &
                  t.studentId.equals(a.studentId),
            ))
            .get();
        if (samePair.any((r) => r.syncStatus != 'synced')) {
          // Keep the pending offline edit; do not create a duplicate row.
          continue;
        }
        if (samePair.isNotEmpty) {
          final canonical = _canonicalAttendance(samePair);
          await _writeServerAttendance(canonical.localId, meetingLocalId, a);
          continue;
        }

        await into(attendanceRecords).insert(
          AttendanceRecordsCompanion.insert(
            remoteId: Value(a.id),
            clientUuid: 'server-${a.id}',
            meetingLocalId: meetingLocalId,
            studentId: a.studentId,
            status: Value(a.status),
            note: Value(a.note),
            syncStatus: const Value('synced'),
          ),
        );
      }

      for (final a in before) {
        if (a.syncStatus == 'synced' &&
            a.remoteId != null &&
            !seenRemote.contains(a.remoteId)) {
          await (delete(
            attendanceRecords,
          )..where((t) => t.localId.equals(a.localId))).go();
        }
      }

      await _collapseAttendanceDuplicates();
    });
  }

  Future<void> _writeServerAttendance(
    int localId,
    int meetingLocalId,
    ServerAttendance a,
  ) =>
      (update(attendanceRecords)..where((t) => t.localId.equals(localId)))
          .write(
            AttendanceRecordsCompanion(
              remoteId: Value(a.id),
              meetingLocalId: Value(meetingLocalId),
              studentId: Value(a.studentId),
              status: Value(a.status),
              note: Value(a.note),
              syncStatus: const Value('synced'),
              updatedAt: Value(DateTime.now()),
            ),
          );

  /// Collapses duplicate attendance rows for the same (meeting, student).
  ///
  /// Keeps the row that best represents the user's data (a pending edit with a
  /// remote id wins, then any row with a remote id, then any pending row).
  Future<void> _collapseAttendanceDuplicates() async {
    final rows = await select(attendanceRecords).get();
    final groups = <String, List<AttendanceRecord>>{};
    for (final r in rows) {
      groups.putIfAbsent('${r.meetingLocalId}:${r.studentId}', () => []).add(r);
    }

    for (final group in groups.values) {
      if (group.length < 2) {
        continue;
      }
      final canonical = _canonicalAttendance(group);
      for (final r in group) {
        if (r.localId == canonical.localId) {
          continue;
        }
        await (delete(pendingOperations)..where(
              (t) =>
                  t.entity.equals('attendance') & t.localId.equals(r.localId),
            ))
            .go();
        await (delete(
          attendanceRecords,
        )..where((t) => t.localId.equals(r.localId))).go();
      }
    }
  }

  /// Removes any pre-existing duplicate attendance rows from the local cache.
  Future<void> dedupeAttendances() =>
      transaction(_collapseAttendanceDuplicates);

  static AttendanceRecord _canonicalAttendance(List<AttendanceRecord> rows) {
    int rank(AttendanceRecord r) {
      final hasRemote = r.remoteId != null;
      final pending = r.syncStatus != 'synced';
      if (hasRemote && pending) {
        return 0;
      }
      if (hasRemote) {
        return 1;
      }
      if (pending) {
        return 2;
      }
      return 3;
    }

    return rows.reduce((a, b) {
      final byRank = rank(a).compareTo(rank(b));
      if (byRank != 0) {
        return byRank < 0 ? a : b;
      }
      return a.updatedAt.isAfter(b.updatedAt) ? a : b;
    });
  }

  Future<int?> _meetingLocalIdForRemote(int remoteId) async {
    final row = await (select(
      meetingRecords,
    )..where((t) => t.remoteId.equals(remoteId))).getSingleOrNull();
    return row?.localId;
  }

  /// Merges server daily test meetings, preserving offline-created rows.
  Future<void> mergeDailyTestMeetings(
    List<ServerDailyTestMeeting> meetings,
  ) async {
    await transaction(() async {
      final synced = await (select(
        dailyTestMeetingRecords,
      )..where((t) => t.syncStatus.equals('synced'))).get();
      final syncedByRemote = {for (final m in synced) m.remoteId: m};
      final seenRemote = <int>{};

      for (final m in meetings) {
        seenRemote.add(m.id);
        final existing = syncedByRemote[m.id];
        if (existing != null) {
          await (update(
            dailyTestMeetingRecords,
          )..where((t) => t.localId.equals(existing.localId))).write(
            DailyTestMeetingRecordsCompanion(
              classId: Value(m.classId),
              className: Value(m.className),
              title: Value(m.title),
              testDate: Value(m.testDate),
              description: Value(m.description),
              updatedAt: Value(DateTime.now()),
            ),
          );
        } else {
          await into(dailyTestMeetingRecords).insert(
            DailyTestMeetingRecordsCompanion.insert(
              remoteId: Value(m.id),
              clientUuid: 'server-${m.id}',
              classId: Value(m.classId),
              className: Value(m.className),
              title: m.title,
              testDate: Value(m.testDate),
              description: Value(m.description),
              syncStatus: const Value('synced'),
            ),
          );
        }
      }

      for (final m in synced) {
        if (m.remoteId != null && !seenRemote.contains(m.remoteId)) {
          await (delete(
            dailyTestScoreRecords,
          )..where((t) => t.meetingLocalId.equals(m.localId))).go();
          await (delete(
            dailyTestMeetingRecords,
          )..where((t) => t.localId.equals(m.localId))).go();
        }
      }
    });
  }

  /// Merges server daily test scores, preserving offline rows.
  Future<void> mergeDailyTestScores(List<ServerDailyTestScore> scores) async {
    await transaction(() async {
      final before = await select(dailyTestScoreRecords).get();
      final byRemote = <int, DailyTestScoreRecord>{
        for (final r in before)
          if (r.remoteId != null) r.remoteId!: r,
      };
      final seenRemote = <int>{};

      for (final s in scores) {
        final meetingLocalId = await _dailyTestMeetingLocalIdForRemote(
          s.meetingRemoteId,
        );
        if (meetingLocalId == null) {
          continue;
        }
        seenRemote.add(s.id);

        final tracked = byRemote[s.id];
        if (tracked != null) {
          if (tracked.syncStatus == 'synced') {
            await _writeServerDailyTestScore(tracked.localId, meetingLocalId, s);
          }
          continue;
        }

        final samePair = await (select(dailyTestScoreRecords)..where(
              (t) =>
                  t.meetingLocalId.equals(meetingLocalId) &
                  t.studentId.equals(s.studentId),
            ))
            .get();
        if (samePair.any((r) => r.syncStatus != 'synced')) {
          // Keep the pending offline edit; do not create a duplicate row.
          continue;
        }
        if (samePair.isNotEmpty) {
          final canonical = _canonicalDailyTestScore(samePair);
          await _writeServerDailyTestScore(canonical.localId, meetingLocalId, s);
          continue;
        }

        await into(dailyTestScoreRecords).insert(
          DailyTestScoreRecordsCompanion.insert(
            remoteId: Value(s.id),
            clientUuid: 'server-${s.id}',
            meetingLocalId: meetingLocalId,
            studentId: s.studentId,
            score: s.score,
            syncStatus: const Value('synced'),
          ),
        );
      }

      for (final r in before) {
        if (r.syncStatus == 'synced' &&
            r.remoteId != null &&
            !seenRemote.contains(r.remoteId)) {
          await (delete(
            dailyTestScoreRecords,
          )..where((t) => t.localId.equals(r.localId))).go();
        }
      }

      await _collapseDailyTestScoreDuplicates();
    });
  }

  Future<void> _writeServerDailyTestScore(
    int localId,
    int meetingLocalId,
    ServerDailyTestScore s,
  ) =>
      (update(dailyTestScoreRecords)..where((t) => t.localId.equals(localId)))
          .write(
            DailyTestScoreRecordsCompanion(
              remoteId: Value(s.id),
              meetingLocalId: Value(meetingLocalId),
              studentId: Value(s.studentId),
              score: Value(s.score),
              syncStatus: const Value('synced'),
              updatedAt: Value(DateTime.now()),
            ),
          );

  /// Collapses duplicate daily test score rows for the same (meeting, student).
  Future<void> _collapseDailyTestScoreDuplicates() async {
    final rows = await select(dailyTestScoreRecords).get();
    final groups = <String, List<DailyTestScoreRecord>>{};
    for (final r in rows) {
      groups.putIfAbsent('${r.meetingLocalId}:${r.studentId}', () => []).add(r);
    }

    for (final group in groups.values) {
      if (group.length < 2) {
        continue;
      }
      final canonical = _canonicalDailyTestScore(group);
      for (final r in group) {
        if (r.localId == canonical.localId) {
          continue;
        }
        await (delete(pendingOperations)..where(
              (t) =>
                  t.entity.equals('daily_test_score') &
                  t.localId.equals(r.localId),
            ))
            .go();
        await (delete(
          dailyTestScoreRecords,
        )..where((t) => t.localId.equals(r.localId))).go();
      }
    }
  }

  /// Removes any pre-existing duplicate daily test score rows from the cache.
  Future<void> dedupeDailyTestScores() =>
      transaction(_collapseDailyTestScoreDuplicates);

  static DailyTestScoreRecord _canonicalDailyTestScore(
    List<DailyTestScoreRecord> rows,
  ) {
    int rank(DailyTestScoreRecord r) {
      final hasRemote = r.remoteId != null;
      final pending = r.syncStatus != 'synced';
      if (hasRemote && pending) {
        return 0;
      }
      if (hasRemote) {
        return 1;
      }
      if (pending) {
        return 2;
      }
      return 3;
    }

    return rows.reduce((a, b) {
      final byRank = rank(a).compareTo(rank(b));
      if (byRank != 0) {
        return byRank < 0 ? a : b;
      }
      return a.updatedAt.isAfter(b.updatedAt) ? a : b;
    });
  }

  Future<int?> _dailyTestMeetingLocalIdForRemote(int remoteId) async {
    final row = await (select(
      dailyTestMeetingRecords,
    )..where((t) => t.remoteId.equals(remoteId))).getSingleOrNull();
    return row?.localId;
  }

  // ---------------------------------------------------------------------------
  // Reads
  // ---------------------------------------------------------------------------

  Stream<List<MeetingRecord>> watchMeetings() =>
      (select(meetingRecords)..orderBy([
            (t) => OrderingTerm(
              expression: t.meetingDate,
              mode: OrderingMode.desc,
            ),
            (t) => OrderingTerm(expression: t.localId, mode: OrderingMode.desc),
          ]))
          .watch();

  Future<List<MeetingRecord>> allMeetings() => select(meetingRecords).get();

  Stream<List<AttendanceRecord>> watchAttendancesForMeeting(
    int meetingLocalId,
  ) => (select(
    attendanceRecords,
  )..where((t) => t.meetingLocalId.equals(meetingLocalId))).watch();

  Future<List<AttendanceRecord>> attendancesForMeeting(int meetingLocalId) =>
      (select(
        attendanceRecords,
      )..where((t) => t.meetingLocalId.equals(meetingLocalId))).get();

  Future<List<CachedStudent>> studentsForClass(int classId) =>
      (select(cachedStudents)..where((t) => t.classId.equals(classId))).get();

  Stream<List<CachedStudent>> watchStudentsForClass(int classId) =>
      (select(cachedStudents)
            ..where((t) => t.classId.equals(classId))
            ..orderBy([(t) => OrderingTerm(expression: t.name)]))
          .watch();

  Stream<List<CachedClass>> watchClasses() => (select(
    cachedClasses,
  )..orderBy([(t) => OrderingTerm(expression: t.name)])).watch();

  Future<List<CachedClass>> allClasses() => select(cachedClasses).get();

  Stream<List<DailyTestMeetingRecord>> watchDailyTestMeetings() =>
      (select(dailyTestMeetingRecords)..orderBy([
            (t) => OrderingTerm(
              expression: t.testDate,
              mode: OrderingMode.desc,
            ),
            (t) => OrderingTerm(expression: t.localId, mode: OrderingMode.desc),
          ]))
          .watch();

  Stream<List<DailyTestScoreRecord>> watchDailyTestScoresForMeeting(
    int meetingLocalId,
  ) => (select(
    dailyTestScoreRecords,
  )..where((t) => t.meetingLocalId.equals(meetingLocalId))).watch();

  Future<List<DailyTestScoreRecord>> dailyTestScoresForMeeting(
    int meetingLocalId,
  ) => (select(
    dailyTestScoreRecords,
  )..where((t) => t.meetingLocalId.equals(meetingLocalId))).get();

  // ---------------------------------------------------------------------------
  // Writes (offline-first)
  // ---------------------------------------------------------------------------

  Future<MeetingRecord> createMeetingLocally({
    required String clientUuid,
    int? classId,
    String? className,
    required String title,
    required String tipe,
    DateTime? meetingDate,
    String? description,
  }) async {
    final localId = await into(meetingRecords).insert(
      MeetingRecordsCompanion.insert(
        clientUuid: clientUuid,
        classId: Value(classId),
        className: Value(className),
        title: title,
        tipe: Value(tipe),
        meetingDate: Value(meetingDate),
        description: Value(description),
        syncStatus: const Value('pending_create'),
      ),
    );
    await enqueue(entity: 'meeting', localId: localId, operation: 'create');
    return (select(
      meetingRecords,
    )..where((t) => t.localId.equals(localId))).getSingle();
  }

  Future<void> updateMeetingLocally(
    MeetingRecord meeting, {
    int? classId,
    String? className,
    String? title,
    String? tipe,
    DateTime? meetingDate,
    String? description,
  }) async {
    final keepPendingCreate = meeting.syncStatus == 'pending_create';
    await (update(
      meetingRecords,
    )..where((t) => t.localId.equals(meeting.localId))).write(
      MeetingRecordsCompanion(
        classId: Value(classId),
        className: Value(className),
        title: Value(title ?? meeting.title),
        tipe: Value(tipe ?? meeting.tipe),
        meetingDate: Value(meetingDate),
        description: Value(description),
        syncStatus: Value(
          keepPendingCreate ? 'pending_create' : 'pending_update',
        ),
        updatedAt: Value(DateTime.now()),
      ),
    );
    if (!keepPendingCreate) {
      await enqueue(
        entity: 'meeting',
        localId: meeting.localId,
        operation: 'update',
      );
    }
  }

  Future<void> deleteMeetingLocally(MeetingRecord meeting) async {
    if (meeting.syncStatus == 'pending_create') {
      await (delete(
        attendanceRecords,
      )..where((t) => t.meetingLocalId.equals(meeting.localId))).go();
      await (delete(pendingOperations)..where(
            (t) =>
                t.entity.equals('meeting') & t.localId.equals(meeting.localId),
          ))
          .go();
      await (delete(
        meetingRecords,
      )..where((t) => t.localId.equals(meeting.localId))).go();
      return;
    }

    await enqueue(
      entity: 'meeting',
      localId: meeting.localId,
      operation: 'delete',
      payload: {'remote_id': meeting.remoteId},
    );
    await (delete(
      attendanceRecords,
    )..where((t) => t.meetingLocalId.equals(meeting.localId))).go();
    await (delete(
      meetingRecords,
    )..where((t) => t.localId.equals(meeting.localId))).go();
  }

  Future<void> saveAttendanceLocally({
    required MeetingRecord meeting,
    required int studentId,
    required String status,
    String? note,
  }) async {
    final matches = await (select(attendanceRecords)..where(
          (t) =>
              t.meetingLocalId.equals(meeting.localId) &
              t.studentId.equals(studentId),
        ))
        .get();

    if (matches.isEmpty) {
      final localId = await into(attendanceRecords).insert(
        AttendanceRecordsCompanion.insert(
          clientUuid: const Uuid().v4(),
          meetingLocalId: meeting.localId,
          studentId: studentId,
          status: Value(status),
          note: Value(note),
        ),
      );
      if (meeting.syncStatus == 'synced') {
        await enqueue(
          entity: 'attendance',
          localId: localId,
          operation: 'create',
        );
      }
      return;
    }

    // Collapse any duplicate rows for this (meeting, student) into one.
    final existing = _canonicalAttendance(matches);
    final hasRemote = existing.remoteId != null;
    await (update(
      attendanceRecords,
    )..where((t) => t.localId.equals(existing.localId))).write(
      AttendanceRecordsCompanion(
        status: Value(status),
        note: Value(note),
        syncStatus: Value(hasRemote ? 'pending_update' : 'pending_create'),
        updatedAt: Value(DateTime.now()),
      ),
    );
    for (final row in matches) {
      if (row.localId == existing.localId) {
        continue;
      }
      await (delete(pendingOperations)..where(
            (t) =>
                t.entity.equals('attendance') & t.localId.equals(row.localId),
          ))
          .go();
      await (delete(
        attendanceRecords,
      )..where((t) => t.localId.equals(row.localId))).go();
    }

    if (meeting.syncStatus == 'synced') {
      if (hasRemote) {
        await enqueue(
          entity: 'attendance',
          localId: existing.localId,
          operation: 'update',
        );
      } else {
        await _ensureAttendanceCreateOp(existing.localId);
      }
    }
  }

  Future<void> _ensureAttendanceCreateOp(int localId) async {
    final pending = await (select(pendingOperations)..where(
          (t) =>
              t.entity.equals('attendance') &
              t.localId.equals(localId) &
              t.operation.equals('create'),
        ))
        .getSingleOrNull();
    if (pending == null) {
      await enqueue(
        entity: 'attendance',
        localId: localId,
        operation: 'create',
      );
    }
  }

  Future<DailyTestMeetingRecord> createDailyTestMeetingLocally({
    required String clientUuid,
    int? classId,
    String? className,
    required String title,
    DateTime? testDate,
    String? description,
  }) async {
    final localId = await into(dailyTestMeetingRecords).insert(
      DailyTestMeetingRecordsCompanion.insert(
        clientUuid: clientUuid,
        classId: Value(classId),
        className: Value(className),
        title: title,
        testDate: Value(testDate),
        description: Value(description),
        syncStatus: const Value('pending_create'),
      ),
    );
    await enqueue(
      entity: 'daily_test_meeting',
      localId: localId,
      operation: 'create',
    );
    return (select(
      dailyTestMeetingRecords,
    )..where((t) => t.localId.equals(localId))).getSingle();
  }

  Future<void> updateDailyTestMeetingLocally(
    DailyTestMeetingRecord meeting, {
    int? classId,
    String? className,
    String? title,
    DateTime? testDate,
    String? description,
  }) async {
    final keepPendingCreate = meeting.syncStatus == 'pending_create';
    await (update(
      dailyTestMeetingRecords,
    )..where((t) => t.localId.equals(meeting.localId))).write(
      DailyTestMeetingRecordsCompanion(
        classId: Value(classId),
        className: Value(className),
        title: Value(title ?? meeting.title),
        testDate: Value(testDate),
        description: Value(description),
        syncStatus: Value(
          keepPendingCreate ? 'pending_create' : 'pending_update',
        ),
        updatedAt: Value(DateTime.now()),
      ),
    );
    if (!keepPendingCreate) {
      await enqueue(
        entity: 'daily_test_meeting',
        localId: meeting.localId,
        operation: 'update',
      );
    }
  }

  Future<void> deleteDailyTestMeetingLocally(
    DailyTestMeetingRecord meeting,
  ) async {
    if (meeting.syncStatus == 'pending_create') {
      await (delete(
        dailyTestScoreRecords,
      )..where((t) => t.meetingLocalId.equals(meeting.localId))).go();
      await (delete(pendingOperations)..where(
            (t) =>
                t.entity.equals('daily_test_meeting') &
                t.localId.equals(meeting.localId),
          ))
          .go();
      await (delete(
        dailyTestMeetingRecords,
      )..where((t) => t.localId.equals(meeting.localId))).go();
      return;
    }

    await enqueue(
      entity: 'daily_test_meeting',
      localId: meeting.localId,
      operation: 'delete',
      payload: {'remote_id': meeting.remoteId},
    );
    await (delete(
      dailyTestScoreRecords,
    )..where((t) => t.meetingLocalId.equals(meeting.localId))).go();
    await (delete(
      dailyTestMeetingRecords,
    )..where((t) => t.localId.equals(meeting.localId))).go();
  }

  Future<void> saveDailyTestScoreLocally({
    required DailyTestMeetingRecord meeting,
    required int studentId,
    required double score,
  }) async {
    final matches = await (select(dailyTestScoreRecords)..where(
          (t) =>
              t.meetingLocalId.equals(meeting.localId) &
              t.studentId.equals(studentId),
        ))
        .get();

    if (matches.isEmpty) {
      final localId = await into(dailyTestScoreRecords).insert(
        DailyTestScoreRecordsCompanion.insert(
          clientUuid: const Uuid().v4(),
          meetingLocalId: meeting.localId,
          studentId: studentId,
          score: score,
        ),
      );
      if (meeting.syncStatus == 'synced') {
        await enqueue(
          entity: 'daily_test_score',
          localId: localId,
          operation: 'create',
        );
      }
      return;
    }

    final existing = _canonicalDailyTestScore(matches);
    final hasRemote = existing.remoteId != null;
    await (update(
      dailyTestScoreRecords,
    )..where((t) => t.localId.equals(existing.localId))).write(
      DailyTestScoreRecordsCompanion(
        score: Value(score),
        syncStatus: Value(hasRemote ? 'pending_update' : 'pending_create'),
        updatedAt: Value(DateTime.now()),
      ),
    );
    for (final row in matches) {
      if (row.localId == existing.localId) {
        continue;
      }
      await (delete(pendingOperations)..where(
            (t) =>
                t.entity.equals('daily_test_score') &
                t.localId.equals(row.localId),
          ))
          .go();
      await (delete(
        dailyTestScoreRecords,
      )..where((t) => t.localId.equals(row.localId))).go();
    }

    if (meeting.syncStatus == 'synced') {
      if (hasRemote) {
        await enqueue(
          entity: 'daily_test_score',
          localId: existing.localId,
          operation: 'update',
        );
      } else {
        await _ensureDailyTestScoreCreateOp(existing.localId);
      }
    }
  }

  Future<void> _ensureDailyTestScoreCreateOp(int localId) async {
    final pending = await (select(pendingOperations)..where(
          (t) =>
              t.entity.equals('daily_test_score') &
              t.localId.equals(localId) &
              t.operation.equals('create'),
        ))
        .getSingleOrNull();
    if (pending == null) {
      await enqueue(
        entity: 'daily_test_score',
        localId: localId,
        operation: 'create',
      );
    }
  }

  // ---------------------------------------------------------------------------
  // Outbox
  // ---------------------------------------------------------------------------

  Future<void> enqueue({
    required String entity,
    required int localId,
    required String operation,
    Map<String, dynamic> payload = const {},
  }) async {
    // Collapse repeated updates into a single pending operation.
    if (operation == 'update') {
      final existing =
          await (select(pendingOperations)..where(
                (t) =>
                    t.entity.equals(entity) &
                    t.localId.equals(localId) &
                    t.operation.equals('update'),
              ))
              .getSingleOrNull();
      if (existing != null) {
        return;
      }
      final pendingCreate =
          await (select(pendingOperations)..where(
                (t) =>
                    t.entity.equals(entity) &
                    t.localId.equals(localId) &
                    t.operation.equals('create'),
              ))
              .getSingleOrNull();
      if (pendingCreate != null) {
        return;
      }
    }

    await into(pendingOperations).insert(
      PendingOperationsCompanion.insert(
        entity: entity,
        localId: localId,
        operation: operation,
        payload: Value(_encode(payload)),
      ),
    );
  }

  Future<List<PendingOperation>> pendingOperationsOrdered() => (select(
    pendingOperations,
  )..orderBy([(t) => OrderingTerm(expression: t.id)])).get();

  Future<MeetingRecord?> meetingByLocalId(int localId) => (select(
    meetingRecords,
  )..where((t) => t.localId.equals(localId))).getSingleOrNull();

  Future<AttendanceRecord?> attendanceByLocalId(int localId) => (select(
    attendanceRecords,
  )..where((t) => t.localId.equals(localId))).getSingleOrNull();

  Future<void> markMeetingSynced(int localId, {int? remoteId}) =>
      (update(meetingRecords)..where((t) => t.localId.equals(localId))).write(
        MeetingRecordsCompanion(
          remoteId: remoteId == null ? const Value.absent() : Value(remoteId),
          syncStatus: const Value('synced'),
        ),
      );

  Future<void> markAttendanceSynced(int localId, {int? remoteId}) =>
      (update(
        attendanceRecords,
      )..where((t) => t.localId.equals(localId))).write(
        AttendanceRecordsCompanion(
          remoteId: remoteId == null ? const Value.absent() : Value(remoteId),
          syncStatus: const Value('synced'),
        ),
      );

  /// Repairs the client UUID of a locally stored attendance row (used to heal
  /// rows created before UUIDs were generated correctly).
  Future<void> setAttendanceClientUuid(int localId, String clientUuid) =>
      (update(attendanceRecords)..where((t) => t.localId.equals(localId)))
          .write(AttendanceRecordsCompanion(clientUuid: Value(clientUuid)));

  /// Queues create operations for attendances belonging to a freshly synced
  /// meeting (used for data captured fully offline).
  Future<void> enqueueAttendanceCreatesForMeeting(int meetingLocalId) async {
    final rows = await attendancesForMeeting(meetingLocalId);
    for (final a in rows) {
      if (a.syncStatus == 'synced') {
        continue;
      }
      final pending =
          await (select(pendingOperations)..where(
                (t) =>
                    t.entity.equals('attendance') & t.localId.equals(a.localId),
              ))
              .getSingleOrNull();
      if (pending != null) {
        continue;
      }
      await (update(
        attendanceRecords,
      )..where((t) => t.localId.equals(a.localId))).write(
        const AttendanceRecordsCompanion(syncStatus: Value('pending_create')),
      );
      await enqueue(
        entity: 'attendance',
        localId: a.localId,
        operation: 'create',
      );
    }
  }

  Future<DailyTestMeetingRecord?> dailyTestMeetingByLocalId(int localId) =>
      (select(
        dailyTestMeetingRecords,
      )..where((t) => t.localId.equals(localId))).getSingleOrNull();

  Future<DailyTestScoreRecord?> dailyTestScoreByLocalId(int localId) =>
      (select(
        dailyTestScoreRecords,
      )..where((t) => t.localId.equals(localId))).getSingleOrNull();

  Future<void> markDailyTestMeetingSynced(int localId, {int? remoteId}) =>
      (update(
        dailyTestMeetingRecords,
      )..where((t) => t.localId.equals(localId))).write(
        DailyTestMeetingRecordsCompanion(
          remoteId: remoteId == null ? const Value.absent() : Value(remoteId),
          syncStatus: const Value('synced'),
        ),
      );

  Future<void> markDailyTestScoreSynced(int localId, {int? remoteId}) =>
      (update(
        dailyTestScoreRecords,
      )..where((t) => t.localId.equals(localId))).write(
        DailyTestScoreRecordsCompanion(
          remoteId: remoteId == null ? const Value.absent() : Value(remoteId),
          syncStatus: const Value('synced'),
        ),
      );

  /// Repairs the client UUID of a locally stored score row.
  Future<void> setDailyTestScoreClientUuid(int localId, String clientUuid) =>
      (update(dailyTestScoreRecords)..where((t) => t.localId.equals(localId)))
          .write(DailyTestScoreRecordsCompanion(clientUuid: Value(clientUuid)));

  /// Queues create operations for scores belonging to a freshly synced meeting
  /// (used for data captured fully offline).
  Future<void> enqueueDailyTestScoreCreatesForMeeting(
    int meetingLocalId,
  ) async {
    final rows = await dailyTestScoresForMeeting(meetingLocalId);
    for (final s in rows) {
      if (s.syncStatus == 'synced') {
        continue;
      }
      final pending = await (select(pendingOperations)..where(
            (t) =>
                t.entity.equals('daily_test_score') &
                t.localId.equals(s.localId),
          ))
          .getSingleOrNull();
      if (pending != null) {
        continue;
      }
      await (update(
        dailyTestScoreRecords,
      )..where((t) => t.localId.equals(s.localId))).write(
        const DailyTestScoreRecordsCompanion(
          syncStatus: Value('pending_create'),
        ),
      );
      await enqueue(
        entity: 'daily_test_score',
        localId: s.localId,
        operation: 'create',
      );
    }
  }

  Future<void> removePendingOperation(int id) =>
      (delete(pendingOperations)..where((t) => t.id.equals(id))).go();

  Future<void> markPendingFailure(int id, String error) async {
    final row = await (select(
      pendingOperations,
    )..where((t) => t.id.equals(id))).getSingleOrNull();
    if (row == null) {
      return;
    }
    await (update(pendingOperations)..where((t) => t.id.equals(id))).write(
      PendingOperationsCompanion(
        attempts: Value(row.attempts + 1),
        lastError: Value(error),
      ),
    );
  }

  Future<int> pendingCount() async {
    final count = pendingOperations.id.count();
    final query = selectOnly(pendingOperations)..addColumns([count]);
    final row = await query.getSingle();
    return row.read(count) ?? 0;
  }

  Future<DateTime?> oldestPendingCreatedAt() async {
    final row =
        await (select(pendingOperations)
              ..orderBy([(t) => OrderingTerm(expression: t.createdAt)])
              ..limit(1))
            .getSingleOrNull();
    return row?.createdAt;
  }

  /// Streams the number of operations waiting to be synced.
  Stream<int> watchPendingCount() {
    final countExp = pendingOperations.id.count();
    final query = selectOnly(pendingOperations)..addColumns([countExp]);
    return query.map((row) => row.read(countExp) ?? 0).watchSingle();
  }

  /// Streams the creation time of the oldest pending operation.
  Stream<DateTime?> watchOldestPendingCreatedAt() {
    final query = select(pendingOperations)
      ..orderBy([(t) => OrderingTerm(expression: t.createdAt)])
      ..limit(1);
    return query.watchSingleOrNull().map((row) => row?.createdAt);
  }

  // ---------------------------------------------------------------------------
  // Dashboard cache
  // ---------------------------------------------------------------------------

  Future<void> saveDashboard(Map<String, dynamic> payload) async {
    await into(cachedDashboard).insertOnConflictUpdate(
      CachedDashboardCompanion.insert(
        payload: _encode(payload),
        fetchedAt: DateTime.now(),
      ),
    );
  }

  Future<DashboardCache?> dashboard() async {
    final row = await (select(cachedDashboard)..limit(1)).getSingleOrNull();
    if (row == null) {
      return null;
    }
    return DashboardCache(
      payload: _decode(row.payload),
      fetchedAt: row.fetchedAt,
    );
  }

  // ---------------------------------------------------------------------------
  // Meta
  // ---------------------------------------------------------------------------

  Future<void> setMeta(String key, String value) => into(appMeta)
      .insertOnConflictUpdate(AppMetaCompanion.insert(key: key, value: value));

  Future<String?> getMeta(String key) async {
    final row = await (select(
      appMeta,
    )..where((t) => t.key.equals(key))).getSingleOrNull();
    return row?.value;
  }

  Future<void> clearUserData() async {
    await transaction(() async {
      await delete(meetingRecords).go();
      await delete(attendanceRecords).go();
      await delete(dailyTestMeetingRecords).go();
      await delete(dailyTestScoreRecords).go();
      await delete(pendingOperations).go();
      await delete(cachedDashboard).go();
      await delete(cachedClasses).go();
      await delete(cachedStudents).go();
    });
  }

  static String _encode(Map<String, dynamic> data) => jsonEncode(data);

  static Map<String, dynamic> _decode(String raw) {
    final decoded = jsonDecode(raw);
    if (decoded is Map<String, dynamic>) {
      return decoded;
    }
    return <String, dynamic>{};
  }

  static QueryExecutor _openConnection() {
    return LazyDatabase(() async {
      final dir = await getApplicationDocumentsDirectory();
      final file = File(p.join(dir.path, 'nilaiq_mobile.sqlite'));
      return NativeDatabase.createInBackground(file);
    });
  }
}

/// Data returned from the dashboard cache.
class DashboardCache {
  DashboardCache({required this.payload, required this.fetchedAt});

  final Map<String, dynamic> payload;
  final DateTime fetchedAt;
}

/// Lightweight DTOs used when merging server responses.
class ServerMeeting {
  ServerMeeting({
    required this.id,
    this.classId,
    this.className,
    required this.title,
    required this.tipe,
    this.meetingDate,
    this.description,
  });

  final int id;
  final int? classId;
  final String? className;
  final String title;
  final String tipe;
  final DateTime? meetingDate;
  final String? description;
}

class ServerAttendance {
  ServerAttendance({
    required this.id,
    required this.meetingRemoteId,
    required this.studentId,
    required this.status,
    this.note,
  });

  final int id;
  final int meetingRemoteId;
  final int studentId;
  final String status;
  final String? note;
}

class ServerDailyTestMeeting {
  ServerDailyTestMeeting({
    required this.id,
    this.classId,
    this.className,
    required this.title,
    this.testDate,
    this.description,
  });

  final int id;
  final int? classId;
  final String? className;
  final String title;
  final DateTime? testDate;
  final String? description;
}

class ServerDailyTestScore {
  ServerDailyTestScore({
    required this.id,
    required this.meetingRemoteId,
    required this.studentId,
    required this.score,
  });

  final int id;
  final int meetingRemoteId;
  final int studentId;
  final double score;
}
