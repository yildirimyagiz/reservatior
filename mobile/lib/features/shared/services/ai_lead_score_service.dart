import 'package:dio/dio.dart';
import '../../../core/network/dio_client.dart';
import '../../../gen_models/models_library.dart';

class AILeadScoreService {
  final DioClient _dioClient;
  AILeadScoreService(this._dioClient);

  // ── Get by ID ──
  Future<AILeadScore> getById(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.get('/aILeadScore/$id');
      return AILeadScore.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get all ──
  Future<List<AILeadScore>> getAll({
    int page = 1, int limit = 20,
    Map<String, dynamic>? filters,
  }) async {
    try {
      final q = <String, dynamic>{'page': page.toString(), 'limit': limit.toString()};
      if (filters != null) q.addAll(filters);
      final r = await _dioClient.get('/aILeadScore', queryParameters: q);
      return (r.data['data'] as List).map((j) => AILeadScore.fromJson(j)).toList();
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get with filters ──
  Future<List<AILeadScore>> getWithFilters({
    double? score,
    dynamic? scoreBreakdown,
    double? confidence,
    DateTime? scoredAt,
    dynamic? featuresUsed,
  }) async {
    final filters = <String, dynamic>{};
    if (score != null) filters['score'] = score.toString();
    if (scoreBreakdown != null) filters['scoreBreakdown'] = scoreBreakdown.toString();
    if (confidence != null) filters['confidence'] = confidence.toString();
    if (scoredAt != null) filters['scoredAt'] = scoredAt.toIso8601String();
    if (featuresUsed != null) filters['featuresUsed'] = featuresUsed.toString();
    return getAll(filters: filters);
  }

  // ── Create ──
  Future<AILeadScore> create(AILeadScore aiLeadScore) async {

    try {
      final r = await _dioClient.post('/aILeadScore', data: aiLeadScore.toJson());
      return AILeadScore.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Update ──
  Future<AILeadScore> update(String id, AILeadScore aiLeadScore) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.put('/aILeadScore/$id', data: aiLeadScore.toJson());
      return AILeadScore.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Delete ──
  Future<void> delete(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      await _dioClient.delete('/aILeadScore/$id');
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