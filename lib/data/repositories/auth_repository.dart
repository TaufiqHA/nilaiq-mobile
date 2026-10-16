import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../core/api_client.dart';
import '../../core/api_exception.dart';
import '../local/database.dart';
import '../remote/auth_api.dart';

/// Handles authentication and session persistence.
class AuthRepository {
  AuthRepository(this._api, this._db)
    : _tokenStorage = TokenStorage(const FlutterSecureStorage());

  final AuthApi _api;
  final AppDatabase _db;
  final TokenStorage _tokenStorage;

  Future<void> _persistUser(String token, Map<String, dynamic> user) async {
    await _tokenStorage.saveToken(token);
    await _tokenStorage.saveUser(jsonEncode(user));
  }

  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    final result = await _api.login(email: email, password: password);
    await _persistUser(result.token, result.user);
    return result.user;
  }

  /// Restores a session on startup.
  ///
  /// Falls back to the cached user when the device is offline so the app can
  /// still be used without an internet connection.
  Future<Map<String, dynamic>?> restoreSession() async {
    final token = await _tokenStorage.readToken();
    if (token == null || token.isEmpty) {
      return null;
    }

    try {
      final user = await _api.me();
      await _tokenStorage.saveUser(jsonEncode(user));
      return user;
    } on ApiException catch (e) {
      if (e.isUnauthenticated) {
        await _tokenStorage.clear();
        return null;
      }
      final cached = await _tokenStorage.readUser();
      if (cached != null) {
        return jsonDecode(cached) as Map<String, dynamic>;
      }
      return null;
    } catch (_) {
      final cached = await _tokenStorage.readUser();
      if (cached != null) {
        return jsonDecode(cached) as Map<String, dynamic>;
      }
      return null;
    }
  }

  Future<void> logout() async {
    try {
      await _api.logout();
    } catch (_) {
      // Ignore network failures while logging out.
    }
    await _tokenStorage.clear();
    await _db.clearUserData();
  }
}
