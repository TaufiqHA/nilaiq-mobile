import '../../core/api_client.dart';

/// Endpoints backing the assignment (tugas) feature.
class AssignmentApi {
  AssignmentApi(this._client);

  final ApiClient _client;

  Future<List<dynamic>> meetings() => _client.getList('/assignment-meetings');

  Future<Map<String, dynamic>> createMeeting(Map<String, dynamic> data) =>
      _client.postJson('/assignment-meetings', data: data);

  Future<Map<String, dynamic>> updateMeeting(
    int id,
    Map<String, dynamic> data,
  ) => _client.putJson('/assignment-meetings/$id', data: data);

  Future<Map<String, dynamic>> deleteMeeting(int id) =>
      _client.deleteJson('/assignment-meetings/$id');

  Future<Map<String, dynamic>> saveScore(Map<String, dynamic> data) =>
      _client.postJson('/assignment-scores', data: data);

  Future<Map<String, dynamic>> updateScore(int id, Map<String, dynamic> data) =>
      _client.putJson('/assignment-scores/$id', data: data);

  Future<Map<String, dynamic>> deleteScore(int id) =>
      _client.deleteJson('/assignment-scores/$id');
}
