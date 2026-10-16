import '../../core/api_client.dart';

/// Authentication endpoints.
class AuthApi {
  AuthApi(this._client);

  final ApiClient _client;

  Future<({String token, Map<String, dynamic> user})> login({
    required String email,
    required String password,
    String? deviceName,
  }) async {
    final res = await _client.postJson(
      '/login',
      data: {
        'email': email,
        'password': password,
        'device_name': deviceName ?? 'mobile',
      },
    );

    return (
      token: res['token'] as String,
      user: (res['user'] as Map).cast<String, dynamic>(),
    );
  }

  Future<Map<String, dynamic>> me() => _client.getJson('/me');

  Future<void> logout() => _client.postJson('/logout');

  Future<bool> health() async {
    try {
      final res = await _client.getJson('/health');
      return res['status'] == 'ok';
    } catch (_) {
      return false;
    }
  }
}
