import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/network/dio_client.dart';
import '../../../gen_models/models_library.dart';

class AIPropertyValuationService {
  final DioClient _dioClient;
  AIPropertyValuationService(this._dioClient);

  // ── Get by ID ──
  Future<AIPropertyValuation> getById(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.get('/aIPropertyValuation/$id');
      return AIPropertyValuation.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get all ──
  Future<List<AIPropertyValuation>> getAll({
    int page = 1, int limit = 20,
    Map<String, dynamic>? filters,
  }) async {
    try {
      final q = <String, dynamic>{'page': page.toString(), 'limit': limit.toString()};
      if (filters != null) q.addAll(filters);
      final r = await _dioClient.get('/aIPropertyValuation', queryParameters: q);
      return (r.data['data'] as List).map((j) => AIPropertyValuation.fromJson(j)).toList();
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get with filters ──
  Future<List<AIPropertyValuation>> getWithFilters({
    double? predictedValue,
    double? confidenceScore,
    DateTime? valuationDate,
    dynamic? inputFeatures,
    dynamic? comparableSales,
  }) async {
    final filters = <String, dynamic>{};
    if (predictedValue != null) filters['predictedValue'] = predictedValue.toString();
    if (confidenceScore != null) filters['confidenceScore'] = confidenceScore.toString();
    if (valuationDate != null) filters['valuationDate'] = valuationDate.toIso8601String();
    if (inputFeatures != null) filters['inputFeatures'] = inputFeatures.toString();
    if (comparableSales != null) filters['comparableSales'] = comparableSales.toString();
    return getAll(filters: filters);
  }

  // ── Create ──
  Future<AIPropertyValuation> create(AIPropertyValuation aiPropertyValuation) async {

    try {
      final r = await _dioClient.post('/aIPropertyValuation', data: aiPropertyValuation.toJson());
      return AIPropertyValuation.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Update ──
  Future<AIPropertyValuation> update(String id, AIPropertyValuation aiPropertyValuation) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.put('/aIPropertyValuation/$id', data: aiPropertyValuation.toJson());
      return AIPropertyValuation.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Delete ──
  Future<void> delete(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      await _dioClient.delete('/aIPropertyValuation/$id');
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