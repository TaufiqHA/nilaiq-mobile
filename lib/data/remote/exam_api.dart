import '../../core/api_client.dart';

/// Endpoints backing the exam (PTS/PAS) feature.
///
/// The website exposes separate resources for midterm and final exams, so the
/// API client is instantiated with the matching paths.
class ExamApi {
  ExamApi(this._client, {required this.examPath, required this.scorePath});

  final ApiClient _client;
  final String examPath;
  final String scorePath;

  Future<List<dynamic>> exams() => _client.getList(examPath);

  Future<Map<String, dynamic>> createExam(Map<String, dynamic> data) =>
      _client.postJson(examPath, data: data);

  Future<Map<String, dynamic>> updateExam(int id, Map<String, dynamic> data) =>
      _client.putJson('$examPath/$id', data: data);

  Future<Map<String, dynamic>> deleteExam(int id) =>
      _client.deleteJson('$examPath/$id');

  Future<Map<String, dynamic>> saveScore(Map<String, dynamic> data) =>
      _client.postJson(scorePath, data: data);

  Future<Map<String, dynamic>> updateScore(int id, Map<String, dynamic> data) =>
      _client.putJson('$scorePath/$id', data: data);

  Future<Map<String, dynamic>> deleteScore(int id) =>
      _client.deleteJson('$scorePath/$id');
}
