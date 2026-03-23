import 'package:dio/dio.dart';
import '../../../core/network/dio_client.dart';
import '../../../gen_models/models_library.dart';

class AISentimentAnalysisService {
  final DioClient _dioClient;
  AISentimentAnalysisService(this._dioClient);

  // ── Get by ID ──
  Future<AISentimentAnalysis> getById(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.get('/aISentimentAnalysis/$id');
      return AISentimentAnalysis.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get all ──
  Future<List<AISentimentAnalysis>> getAll({
    int page = 1, int limit = 20,
    Map<String, dynamic>? filters,
  }) async {
    try {
      final q = <String, dynamic>{'page': page.toString(), 'limit': limit.toString()};
      if (filters != null) q.addAll(filters);
      final r = await _dioClient.get('/aISentimentAnalysis', queryParameters: q);
      return (r.data['data'] as List).map((j) => AISentimentAnalysis.fromJson(j)).toList();
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get with filters ──
  Future<List<AISentimentAnalysis>> getWithFilters({
    String? contentType,
    String? contentText,
    String? sentiment,
    double? sentimentScore,
    double? confidence,
  }) async {
    final filters = <String, dynamic>{};
    if (contentType != null) filters['contentType'] = contentType;
    if (contentText != null) filters['contentText'] = contentText;
    if (sentiment != null) filters['sentiment'] = sentiment;
    if (sentimentScore != null) filters['sentimentScore'] = sentimentScore.toString();
    if (confidence != null) filters['confidence'] = confidence.toString();
    return getAll(filters: filters);
  }

  // ── Create ──
  Future<AISentimentAnalysis> create(AISentimentAnalysis aiSentimentAnalysis) async {

    try {
      final r = await _dioClient.post('/aISentimentAnalysis', data: aiSentimentAnalysis.toJson());
      return AISentimentAnalysis.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Update ──
  Future<AISentimentAnalysis> update(String id, AISentimentAnalysis aiSentimentAnalysis) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.put('/aISentimentAnalysis/$id', data: aiSentimentAnalysis.toJson());
      return AISentimentAnalysis.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Delete ──
  Future<void> delete(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      await _dioClient.delete('/aISentimentAnalysis/$id');
    } on DioException catch (e) { throw _err(e); }
  }

  Exception _err(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return Exception('Connection timeout. Check your internet connection.');
      case DioExceptionType.badResponse:
        final msg = e.response?.data?['message'] ?? 'Server error';
        return Exception('Server error: $msg');
      case DioExceptionType.connectionError:
        return Exception('Network error. Check your internet connection.');
      default:
        return Exception('Request failed: ${e.message}');
    }
  }
}