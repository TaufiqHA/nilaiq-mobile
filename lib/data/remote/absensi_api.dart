import '../../core/api_client.dart';

/// Endpoints backing the attendance (absensi) feature.
class AbsensiApi {
  AbsensiApi(this._client);

  final ApiClient _client;

  Future<List<dynamic>> meetings() => _client.getList('/attendance-meetings');

  Future<List<dynamic>> classes() => _client.getList('/classes');

  Future<Map<String, dynamic>> createMeeting(Map<String, dynamic> data) =>
      _client.postJson('/attendance-meetings', data: data);

  Future<Map<String, dynamic>> updateMeeting(
    int id,
    Map<String, dynamic> data,
  ) => _client.putJson('/attendance-meetings/$id', data: data);

  Future<Map<String, dynamic>> deleteMeeting(int id) =>
      _client.deleteJson('/attendance-meetings/$id');

  Future<Map<String, dynamic>> saveAttendance(Map<String, dynamic> data) =>
      _client.postJson('/attendances', data: data);

  Future<Map<String, dynamic>> updateAttendance(
    int id,
    Map<String, dynamic> data,
  ) => _client.putJson('/attendances/$id', data: data);

  Future<Map<String, dynamic>> deleteAttendance(int id) =>
      _client.deleteJson('/attendances/$id');

  Future<Map<String, dynamic>> rekap(int classId) =>
      _client.getJson('/rekap-absensi', query: {'class_id': classId});
}
