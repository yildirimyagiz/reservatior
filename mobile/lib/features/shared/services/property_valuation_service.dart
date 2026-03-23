import 'package:dio/dio.dart';
import '../../../core/network/dio_client.dart';
import '../../../gen_models/models_library.dart';

class PropertyValuationService {
  final DioClient _dioClient;
  PropertyValuationService(this._dioClient);

  // ── Get by ID ──
  Future<PropertyValuation> getById(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.get('/propertyValuation/$id');
      return PropertyValuation.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get all ──
  Future<List<PropertyValuation>> getAll({
    int page = 1, int limit = 20,
    Map<String, dynamic>? filters,
  }) async {
    try {
      final q = <String, dynamic>{'page': page.toString(), 'limit': limit.toString()};
      if (filters != null) q.addAll(filters);
      final r = await _dioClient.get('/propertyValuation', queryParameters: q);
      return (r.data['data'] as List).map((j) => PropertyValuation.fromJson(j)).toList();
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get with filters ──
  Future<List<PropertyValuation>> getWithFilters({
    DateTime? valuationDate,
    double? value,
    String? source,
    double? confidence,
  }) async {
    final filters = <String, dynamic>{};
    if (valuationDate != null) filters['valuationDate'] = valuationDate.toIso8601String();
    if (value != null) filters['value'] = value.toString();
    if (source != null) filters['source'] = source;
    if (confidence != null) filters['confidence'] = confidence.toString();
    return getAll(filters: filters);
  }

  // ── Create ──
  Future<PropertyValuation> create(PropertyValuation propertyValuation) async {

    try {
      final r = await _dioClient.post('/propertyValuation', data: propertyValuation.toJson());
      return PropertyValuation.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Update ──
  Future<PropertyValuation> update(String id, PropertyValuation propertyValuation) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.put('/propertyValuation/$id', data: propertyValuation.toJson());
      return PropertyValuation.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Delete ──
  Future<void> delete(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      await _dioClient.delete('/propertyValuation/$id');
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