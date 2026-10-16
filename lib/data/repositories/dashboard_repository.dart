import '../local/database.dart';
import '../remote/dashboard_api.dart';

/// Loads and caches the dashboard payload.
class DashboardRepository {
  DashboardRepository(this._db, this._api);

  final AppDatabase _db;
  final DashboardApi _api;

  Future<void> refresh() async {
    final payload = await _api.fetch();
    await _db.saveDashboard(payload);
  }

  Future<DashboardCache?> cached() => _db.dashboard();
}
