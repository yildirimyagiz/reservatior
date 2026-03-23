import 'package:dio/dio.dart';
import '../../../core/network/dio_client.dart';
import '../../../gen_models/models_library.dart';

class AIPriceOptimizationService {
  final DioClient _dioClient;
  AIPriceOptimizationService(this._dioClient);

  // ── Get by ID ──
  Future<AIPriceOptimization> getById(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.get('/aIPriceOptimization/$id');
      return AIPriceOptimization.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get all ──
  Future<List<AIPriceOptimization>> getAll({
    int page = 1, int limit = 20,
    Map<String, dynamic>? filters,
  }) async {
    try {
      final q = <String, dynamic>{'page': page.toString(), 'limit': limit.toString()};
      if (filters != null) q.addAll(filters);
      final r = await _dioClient.get('/aIPriceOptimization', queryParameters: q);
      return (r.data['data'] as List).map((j) => AIPriceOptimization.fromJson(j)).toList();
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get with filters ──
  Future<List<AIPriceOptimization>> getWithFilters({
    double? currentPrice,
    double? recommendedPrice,
    dynamic? priceRange,
    dynamic? factors,
    dynamic? comparableData,
  }) async {
    final filters = <String, dynamic>{};
    if (currentPrice != null) filters['currentPrice'] = currentPrice.toString();
    if (recommendedPrice != null) filters['recommendedPrice'] = recommendedPrice.toString();
    if (priceRange != null) filters['priceRange'] = priceRange.toString();
    if (factors != null) filters['factors'] = factors.toString();
    if (comparableData != null) filters['comparableData'] = comparableData.toString();
    return getAll(filters: filters);
  }

  // ── Create ──
  Future<AIPriceOptimization> create(AIPriceOptimization aiPriceOptimization) async {

    try {
      final r = await _dioClient.post('/aIPriceOptimization', data: aiPriceOptimization.toJson());
      return AIPriceOptimization.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Update ──
  Future<AIPriceOptimization> update(String id, AIPriceOptimization aiPriceOptimization) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.put('/aIPriceOptimization/$id', data: aiPriceOptimization.toJson());
      return AIPriceOptimization.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Delete ──
  Future<void> delete(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      await _dioClient.delete('/aIPriceOptimization/$id');
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