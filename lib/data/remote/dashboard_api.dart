import '../../core/api_client.dart';

/// Endpoints backing the dashboard screen.
class DashboardApi {
  DashboardApi(this._client);

  final ApiClient _client;

  Future<Map<String, dynamic>> fetch() => _client.getJson('/dashboard');
}
