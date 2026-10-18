import 'dart:convert';

import 'package:dio/dio.dart';

import '../../core/api_client.dart';
import '../../core/api_exception.dart';

/// Result of an AI grade-scan request.
class ScoreScanResult {
  const ScoreScanResult({required this.scores, this.message});

  /// Map of student id to detected score.
  final Map<int, double> scores;
  final String? message;
}

/// Uploads a photo of a grading sheet and maps detected scores to students.
class ScoreScanApi {
  ScoreScanApi(this._client);

  final ApiClient _client;

  Future<ScoreScanResult> scan({
    required String imagePath,
    required List<({int id, String name})> students,
  }) async {
    final formData = FormData.fromMap({
      'image': await MultipartFile.fromFile(imagePath),
      'students': jsonEncode([
        for (final s in students) {'id': s.id, 'name': s.name},
      ]),
    });

    Response<dynamic> response;
    try {
      response = await _client.raw.post<dynamic>(
        '/score-scan',
        data: formData,
        options: Options(
          sendTimeout: const Duration(seconds: 60),
          receiveTimeout: const Duration(seconds: 60),
        ),
      );
    } on DioException catch (e) {
      throw ApiException(
        e.message ?? 'Gagal memproses gambar. Periksa koneksi internet Anda.',
      );
    }

    final status = response.statusCode ?? 0;
    final body = response.data;
    final map = body is Map
        ? body.cast<String, dynamic>()
        : <String, dynamic>{};

    if (status < 200 || status >= 300) {
      throw ApiException(
        map['message']?.toString() ?? 'Gagal memproses gambar (HTTP $status).',
        statusCode: status,
      );
    }

    final success = map['success'] == true;
    final rawData = map['data'];
    if (!success || rawData is! List) {
      throw ApiException(
        map['message']?.toString() ?? 'Gagal mendeteksi nilai dari gambar.',
      );
    }

    final scores = <int, double>{};
    for (final item in rawData) {
      if (item is! Map) {
        continue;
      }
      final studentId = _asInt(item['student_id']);
      final score = _asDouble(item['score']);
      if (studentId != null && score != null) {
        scores[studentId] = score;
      }
    }

    if (scores.isEmpty) {
      throw ApiException(
        'Tidak ada nilai yang berhasil dideteksi dari gambar.',
      );
    }

    return ScoreScanResult(scores: scores, message: map['message']?.toString());
  }

  static int? _asInt(dynamic value) {
    if (value is int) {
      return value;
    }
    if (value is num) {
      return value.toInt();
    }
    return int.tryParse(value?.toString() ?? '');
  }

  static double? _asDouble(dynamic value) {
    if (value is num) {
      return value.toDouble();
    }
    return double.tryParse(value?.toString() ?? '');
  }
}
