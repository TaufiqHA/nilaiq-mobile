import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'api_exception.dart';
import 'env.dart';

/// Persists the Sanctum bearer token in secure storage.
class TokenStorage {
  TokenStorage(this._storage);

  final FlutterSecureStorage _storage;

  static const _tokenKey = 'nilaiq_token';
  static const _userKey = 'nilaiq_user';

  Future<String?> readToken() => _storage.read(key: _tokenKey);

  Future<void> saveToken(String token) =>
      _storage.write(key: _tokenKey, value: token);

  Future<String?> readUser() => _storage.read(key: _userKey);

  Future<void> saveUser(String json) =>
      _storage.write(key: _userKey, value: json);

  Future<void> clear() async {
    await _storage.delete(key: _tokenKey);
    await _storage.delete(key: _userKey);
  }
}

/// Thin wrapper around [Dio] providing JSON helpers and error mapping.
class ApiClient {
  ApiClient(this._tokenStorage, {Dio? dio})
    : _dio =
          dio ??
          Dio(
            BaseOptions(
              baseUrl: Env.apiBaseUrl,
              connectTimeout: const Duration(seconds: 15),
              receiveTimeout: const Duration(seconds: 20),
              sendTimeout: const Duration(seconds: 20),
              headers: {'Accept': 'application/json'},
              // Let callers handle non-2xx status codes explicitly.
              validateStatus: (_) => true,
            ),
          ) {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await _tokenStorage.readToken();
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          handler.next(options);
        },
      ),
    );
  }

  final Dio _dio;
  final TokenStorage _tokenStorage;

  Dio get raw => _dio;

  Future<Map<String, dynamic>> getJson(
    String path, {
    Map<String, dynamic>? query,
  }) => _request('GET', path, query: query);

  Future<Map<String, dynamic>> postJson(String path, {Object? data}) =>
      _request('POST', path, data: data);

  Future<Map<String, dynamic>> putJson(String path, {Object? data}) =>
      _request('PUT', path, data: data);

  Future<Map<String, dynamic>> deleteJson(String path, {Object? data}) =>
      _request('DELETE', path, data: data);

  Future<Map<String, dynamic>> _request(
    String method,
    String path, {
    Object? data,
    Map<String, dynamic>? query,
  }) async {
    Response<dynamic> response;
    try {
      response = await _dio.request<dynamic>(
        path,
        data: data,
        queryParameters: query,
        options: Options(method: method),
      );
    } on DioException catch (e) {
      throw ApiException(_dioMessage(e));
    }

    final status = response.statusCode ?? 0;
    final body = response.data;

    if (status >= 200 && status < 300) {
      if (body is Map<String, dynamic>) {
        return body;
      }
      if (body is Map) {
        return body.cast<String, dynamic>();
      }
      if (body is List) {
        return {'data': body};
      }
      if (body is String && body.trim().isNotEmpty) {
        // A server that returns HTML (e.g. a login redirect followed by Dio)
        // must not be treated as a successful JSON response.
        throw ApiException(
          'Respons server tidak valid (bukan JSON).',
          statusCode: status,
        );
      }
      return <String, dynamic>{};
    }

    throw _mapError(status, body);
  }

  /// Performs a GET expecting a top-level JSON list response.
  Future<List<dynamic>> getList(
    String path, {
    Map<String, dynamic>? query,
  }) async {
    Response<dynamic> response;
    try {
      response = await _dio.get<dynamic>(path, queryParameters: query);
    } on DioException catch (e) {
      throw ApiException(_dioMessage(e));
    }

    final status = response.statusCode ?? 0;
    if (status >= 200 && status < 300) {
      final body = response.data;
      if (body is List) {
        return body;
      }
      if (body is Map<String, dynamic> && body['data'] is List) {
        return body['data'] as List<dynamic>;
      }
      if (body is Map && body['data'] is List) {
        return body['data'] as List<dynamic>;
      }
      throw ApiException(
        'Respons server tidak valid (bukan daftar).',
        statusCode: status,
      );
    }

    throw _mapError(status, response.data);
  }

  ApiException _mapError(int status, dynamic body) {
    String message = 'Terjadi kesalahan (HTTP $status).';
    Map<String, List<String>>? errors;

    if (body is Map<String, dynamic>) {
      final rawMessage = body['message'];
      if (rawMessage is String && rawMessage.isNotEmpty) {
        message = rawMessage;
      }
      final rawErrors = body['errors'];
      if (rawErrors is Map<String, dynamic>) {
        errors = rawErrors.map(
          (key, value) => MapEntry(
            key,
            value is List
                ? value.map((e) => e.toString()).toList()
                : <String>[value.toString()],
          ),
        );
        if (errors.isNotEmpty) {
          message = errors.values.first.first;
        }
      }
    }

    return ApiException(message, statusCode: status, errors: errors);
  }

  String _dioMessage(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return 'Koneksi ke server timeout. Periksa jaringan Anda.';
      case DioExceptionType.connectionError:
        return 'Tidak dapat terhubung ke server. Periksa koneksi internet Anda.';
      default:
        return e.message ?? 'Terjadi kesalahan jaringan.';
    }
  }
}
