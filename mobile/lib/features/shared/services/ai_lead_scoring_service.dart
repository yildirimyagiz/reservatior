import 'package:dio/dio.dart';
import '../../../core/network/dio_client.dart';
import '../../../gen_models/models_library.dart';

class AILeadScoringService {
  final DioClient _dioClient;
  AILeadScoringService(this._dioClient);

  // ── Get by ID ──
  Future<AILeadScoring> getById(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.get('/aILeadScoring/$id');
      return AILeadScoring.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get all ──
  Future<List<AILeadScoring>> getAll({
    int page = 1, int limit = 20,
    Map<String, dynamic>? filters,
  }) async {
    try {
      final q = <String, dynamic>{'page': page.toString(), 'limit': limit.toString()};
      if (filters != null) q.addAll(filters);
      final r = await _dioClient.get('/aILeadScoring', queryParameters: q);
      return (r.data['data'] as List).map((j) => AILeadScoring.fromJson(j)).toList();
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get with filters ──
  Future<List<AILeadScoring>> getWithFilters({
    String? modelName,
    String? modelVersion,
    double? accuracy,
    DateTime? lastTrainedAt,
    dynamic? features,
  }) async {
    final filters = <String, dynamic>{};
    if (modelName != null) filters['modelName'] = modelName;
    if (modelVersion != null) filters['modelVersion'] = modelVersion;
    if (accuracy != null) filters['accuracy'] = accuracy.toString();
    if (lastTrainedAt != null) filters['lastTrainedAt'] = lastTrainedAt.toIso8601String();
    if (features != null) filters['features'] = features.toString();
    return getAll(filters: filters);
  }

  // ── Create ──
  Future<AILeadScoring> create(AILeadScoring aiLeadScoring) async {

    try {
      final r = await _dioClient.post('/aILeadScoring', data: aiLeadScoring.toJson());
      return AILeadScoring.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Update ──
  Future<AILeadScoring> update(String id, AILeadScoring aiLeadScoring) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.put('/aILeadScoring/$id', data: aiLeadScoring.toJson());
      return AILeadScoring.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Delete ──
  Future<void> delete(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      await _dioClient.delete('/aILeadScoring/$id');
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