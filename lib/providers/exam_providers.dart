import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../data/local/database.dart';
import 'infrastructure_providers.dart';
import 'sync_provider.dart';

/// Live list of PTS exams from the local cache.
final midtermExamsProvider = StreamProvider<List<ExamRecord>>(
  (ref) => ref.watch(databaseProvider).watchExamRecords(examKindMidterm),
);

/// Live list of PAS exams from the local cache.
final finalExamsProvider = StreamProvider<List<ExamRecord>>(
  (ref) => ref.watch(databaseProvider).watchExamRecords(examKindFinal),
);

/// Live score records for a given local exam id.
final examScoresProvider = StreamProvider.family<List<ExamScoreRecord>, int>(
  (ref, examLocalId) =>
      ref.watch(databaseProvider).watchExamScoresForExam(examLocalId),
);

final examActionsProvider = Provider.family<ExamActions, String>(
  (ref, kind) => ExamActions(ref, kind),
);

/// Write operations for the PTS/PAS feature. All writes hit the local database
/// first, then attempt a background sync.
class ExamActions {
  ExamActions(this._ref, this.kind);

  final Ref _ref;
  final String kind;
  static const _uuid = Uuid();

  AppDatabase get _db => _ref.read(databaseProvider);

  Future<void> refresh() => _ref.read(syncControllerProvider.notifier).sync();

  void _sync() => unawaited(_ref.read(syncControllerProvider.notifier).sync());

  Future<void> createExam({
    int? classId,
    String? className,
    required String title,
    DateTime? examDate,
    String? description,
  }) async {
    await _db.createExamLocally(
      clientUuid: _uuid.v4(),
      kind: kind,
      classId: classId,
      className: className,
      title: title,
      examDate: examDate,
      description: description,
    );
    _sync();
  }

  Future<void> updateExam(
    ExamRecord exam, {
    int? classId,
    String? className,
    required String title,
    DateTime? examDate,
    String? description,
  }) async {
    await _db.updateExamLocally(
      exam,
      classId: classId,
      className: className,
      title: title,
      examDate: examDate,
      description: description,
    );
    _sync();
  }

  Future<void> deleteExam(ExamRecord exam) async {
    await _db.deleteExamLocally(exam);
    _sync();
  }

  Future<void> saveScore({
    required ExamRecord exam,
    required int studentId,
    required double score,
  }) async {
    await _db.saveExamScoreLocally(
      exam: exam,
      studentId: studentId,
      score: score,
    );
    _sync();
  }
}
