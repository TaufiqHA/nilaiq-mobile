import '../../core/api_client.dart';

/// Endpoints backing the daily test (ulangan harian) feature.
class DailyTestApi {
  DailyTestApi(this._client);

  final ApiClient _client;

  Future<List<dynamic>> meetings() => _client.getList('/daily-test-meetings');

  Future<Map<String, dynamic>> createMeeting(Map<String, dynamic> data) =>
      _client.postJson('/daily-test-meetings', data: data);

  Future<Map<String, dynamic>> updateMeeting(
    int id,
    Map<String, dynamic> data,
  ) => _client.putJson('/daily-test-meetings/$id', data: data);

  Future<Map<String, dynamic>> deleteMeeting(int id) =>
      _client.deleteJson('/daily-test-meetings/$id');

  Future<Map<String, dynamic>> saveScore(Map<String, dynamic> data) =>
      _client.postJson('/daily-test-scores', data: data);

  Future<Map<String, dynamic>> updateScore(
    int id,
    Map<String, dynamic> data,
  ) => _client.putJson('/daily-test-scores/$id', data: data);

  Future<Map<String, dynamic>> deleteScore(int id) =>
      _client.deleteJson('/daily-test-scores/$id');
}
