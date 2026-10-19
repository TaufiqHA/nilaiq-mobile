import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../core/api_client.dart';
import '../core/connectivity_service.dart';
import '../data/local/database.dart';
import '../data/remote/absensi_api.dart';
import '../data/remote/assignment_api.dart';
import '../data/remote/auth_api.dart';
import '../data/remote/daily_test_api.dart';
import '../data/remote/dashboard_api.dart';
import '../data/remote/exam_api.dart';
import '../data/remote/score_scan_api.dart';
import '../data/repositories/absensi_repository.dart';
import '../data/repositories/assignment_repository.dart';
import '../data/repositories/auth_repository.dart';
import '../data/repositories/daily_test_repository.dart';
import '../data/repositories/dashboard_repository.dart';
import '../data/repositories/exam_repository.dart';
import '../data/sync/sync_service.dart';

final tokenStorageProvider = Provider<TokenStorage>(
  (ref) => TokenStorage(const FlutterSecureStorage()),
);

final apiClientProvider = Provider<ApiClient>(
  (ref) => ApiClient(ref.watch(tokenStorageProvider)),
);

final authApiProvider = Provider<AuthApi>(
  (ref) => AuthApi(ref.watch(apiClientProvider)),
);

final dashboardApiProvider = Provider<DashboardApi>(
  (ref) => DashboardApi(ref.watch(apiClientProvider)),
);

final absensiApiProvider = Provider<AbsensiApi>(
  (ref) => AbsensiApi(ref.watch(apiClientProvider)),
);

final dailyTestApiProvider = Provider<DailyTestApi>(
  (ref) => DailyTestApi(ref.watch(apiClientProvider)),
);

final assignmentApiProvider = Provider<AssignmentApi>(
  (ref) => AssignmentApi(ref.watch(apiClientProvider)),
);

final midtermExamApiProvider = Provider<ExamApi>(
  (ref) => ExamApi(
    ref.watch(apiClientProvider),
    examPath: '/midterm-exams',
    scorePath: '/midterm-scores',
  ),
);

final finalExamApiProvider = Provider<ExamApi>(
  (ref) => ExamApi(
    ref.watch(apiClientProvider),
    examPath: '/final-exams',
    scorePath: '/final-scores',
  ),
);

final scoreScanApiProvider = Provider<ScoreScanApi>(
  (ref) => ScoreScanApi(ref.watch(apiClientProvider)),
);

final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});

final connectivityProvider = Provider<ConnectivityService>(
  (ref) => ConnectivityService(),
);

/// Emits `true` whenever the device regains a network connection.
final connectivityStatusProvider = StreamProvider<bool>(
  (ref) => ref.watch(connectivityProvider).onStatusChange,
);

final absensiRepositoryProvider = Provider<AbsensiRepository>(
  (ref) => AbsensiRepository(
    ref.watch(databaseProvider),
    ref.watch(absensiApiProvider),
  ),
);

final dailyTestRepositoryProvider = Provider<DailyTestRepository>(
  (ref) => DailyTestRepository(
    ref.watch(databaseProvider),
    ref.watch(dailyTestApiProvider),
  ),
);

final assignmentRepositoryProvider = Provider<AssignmentRepository>(
  (ref) => AssignmentRepository(
    ref.watch(databaseProvider),
    ref.watch(assignmentApiProvider),
  ),
);

final midtermExamRepositoryProvider = Provider<ExamRepository>(
  (ref) => ExamRepository(
    ref.watch(databaseProvider),
    ref.watch(midtermExamApiProvider),
    examKindMidterm,
  ),
);

final finalExamRepositoryProvider = Provider<ExamRepository>(
  (ref) => ExamRepository(
    ref.watch(databaseProvider),
    ref.watch(finalExamApiProvider),
    examKindFinal,
  ),
);

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) =>
      AuthRepository(ref.watch(authApiProvider), ref.watch(databaseProvider)),
);

final dashboardRepositoryProvider = Provider<DashboardRepository>(
  (ref) => DashboardRepository(
    ref.watch(databaseProvider),
    ref.watch(dashboardApiProvider),
  ),
);

final syncServiceProvider = Provider<SyncService>(
  (ref) => SyncService(
    ref.watch(databaseProvider),
    ref.watch(absensiApiProvider),
    ref.watch(absensiRepositoryProvider),
    ref.watch(connectivityProvider),
    ref.watch(dailyTestApiProvider),
    ref.watch(dailyTestRepositoryProvider),
    ref.watch(assignmentApiProvider),
    ref.watch(assignmentRepositoryProvider),
    ref.watch(midtermExamApiProvider),
    ref.watch(midtermExamRepositoryProvider),
    ref.watch(finalExamApiProvider),
    ref.watch(finalExamRepositoryProvider),
  ),
);
