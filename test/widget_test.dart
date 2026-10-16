import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nilaiq_mobile/data/local/database.dart';

void main() {
  late AppDatabase db;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
  });

  tearDown(() async {
    await db.close();
  });

  test(
    'creating a meeting offline enqueues a pending create operation',
    () async {
      final meeting = await db.createMeetingLocally(
        clientUuid: 'uuid-1',
        classId: 1,
        className: 'Kelas X',
        title: 'Pertemuan Pertama',
        tipe: 'harian',
        meetingDate: DateTime(2026, 7, 18),
      );

      expect(meeting.syncStatus, 'pending_create');
      expect(await db.pendingCount(), 1);
    },
  );

  test('saving attendance for a pending meeting keeps a single local row', () async {
    final meeting = await db.createMeetingLocally(
      clientUuid: 'uuid-2',
      classId: 1,
      className: 'Kelas X',
      title: 'Pertemuan Kedua',
      tipe: 'harian',
    );

    await db.saveAttendanceLocally(
      meeting: meeting,
      studentId: 10,
      status: 'HADIR',
      note: null,
    );
    await db.saveAttendanceLocally(
      meeting: meeting,
      studentId: 10,
      status: 'SAKIT',
      note: 'Demam',
    );

    final rows = await db.attendancesForMeeting(meeting.localId);
    expect(rows, hasLength(1));
    expect(rows.single.status, 'SAKIT');
    expect(rows.single.note, 'Demam');
    // Only the meeting create should be queued (attendance waits for meeting).
    expect(await db.pendingCount(), 1);
  });

  test(
    'deleting an unsynced meeting clears its local rows and queue',
    () async {
      final meeting = await db.createMeetingLocally(
        clientUuid: 'uuid-3',
        classId: 1,
        className: 'Kelas X',
        title: 'Pertemuan Ketiga',
        tipe: 'tugas',
      );
      await db.saveAttendanceLocally(
        meeting: meeting,
        studentId: 1,
        status: 'HADIR',
      );

      await db.deleteMeetingLocally(meeting);

      expect(await db.allMeetings(), isEmpty);
      expect(await db.pendingCount(), 0);
    },
  );

  test('merging server meetings preserves offline-created rows', () async {
    await db.createMeetingLocally(
      clientUuid: 'uuid-4',
      classId: 1,
      className: 'Kelas X',
      title: 'Offline Meeting',
      tipe: 'harian',
    );

    await db.mergeMeetings([
      ServerMeeting(
        id: 99,
        classId: 2,
        className: 'Kelas XI',
        title: 'Server Meeting',
        tipe: 'harian',
        meetingDate: DateTime(2026, 7, 19),
      ),
    ]);

    final meetings = await db.allMeetings();
    expect(meetings, hasLength(2));
    expect(meetings.any((m) => m.title == 'Offline Meeting'), isTrue);
    expect(meetings.any((m) => m.title == 'Server Meeting'), isTrue);
  });

  test('attendance rows get a valid UUID client id', () async {
    final meeting = await db.createMeetingLocally(
      clientUuid: '3198a4a2-8f8f-4d0f-9f1e-2f1c2b3a4d5e',
      classId: 1,
      className: 'Kelas X',
      title: 'Pertemuan UUID',
      tipe: 'harian',
    );

    await db.saveAttendanceLocally(
      meeting: meeting,
      studentId: 7,
      status: 'HADIR',
    );

    final rows = await db.attendancesForMeeting(meeting.localId);
    expect(rows, hasLength(1));
    expect(
      RegExp(
        r'^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$',
      ).hasMatch(rows.single.clientUuid),
      isTrue,
      reason:
          'client_uuid must be a valid UUID to pass server validation, got '
          '${rows.single.clientUuid}',
    );
  });

  test('saving attendance tolerates and collapses duplicate rows', () async {
    final meeting = await db.createMeetingLocally(
      clientUuid: '11111111-1111-4111-8111-111111111111',
      classId: 1,
      className: 'Kelas X',
      title: 'Duplikat',
      tipe: 'harian',
    );

    for (var i = 0; i < 2; i++) {
      await db.into(db.attendanceRecords).insert(
        AttendanceRecordsCompanion.insert(
          remoteId: Value(100 + i),
          clientUuid: 'server-${100 + i}',
          meetingLocalId: meeting.localId,
          studentId: 5,
          status: const Value('HADIR'),
          syncStatus: const Value('synced'),
        ),
      );
    }
    expect(await db.attendancesForMeeting(meeting.localId), hasLength(2));

    // Must not throw (previously a StateError from getSingleOrNull).
    await db.saveAttendanceLocally(
      meeting: meeting,
      studentId: 5,
      status: 'SAKIT',
    );

    final rows = await db.attendancesForMeeting(meeting.localId);
    expect(rows, hasLength(1));
    expect(rows.single.status, 'SAKIT');
  });

  test('merging duplicate server attendances keeps a single row', () async {
    await db.into(db.meetingRecords).insert(
      MeetingRecordsCompanion.insert(
        remoteId: const Value(50),
        clientUuid: 'server-50',
        title: 'Pertemuan Server',
        syncStatus: const Value('synced'),
      ),
    );
    final localId = (await db.allMeetings()).single.localId;

    await db.mergeAttendances([
      ServerAttendance(
        id: 201,
        meetingRemoteId: 50,
        studentId: 9,
        status: 'HADIR',
      ),
      ServerAttendance(
        id: 202,
        meetingRemoteId: 50,
        studentId: 9,
        status: 'ALFA',
      ),
    ]);

    final rows = await db.attendancesForMeeting(localId);
    expect(rows, hasLength(1));
  });
}
