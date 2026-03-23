import 'package:dio/dio.dart';
import '../../../core/network/dio_client.dart';
import '../../../gen_models/models_library.dart';

class PropertyPromotionService {
  final DioClient _dioClient;
  PropertyPromotionService(this._dioClient);

  // ── Get by ID ──
  Future<PropertyPromotion> getById(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.get('/propertyPromotion/$id');
      return PropertyPromotion.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get all ──
  Future<List<PropertyPromotion>> getAll({
    int page = 1, int limit = 20,
    Map<String, dynamic>? filters,
  }) async {
    try {
      final q = <String, dynamic>{'page': page.toString(), 'limit': limit.toString()};
      if (filters != null) q.addAll(filters);
      final r = await _dioClient.get('/propertyPromotion', queryParameters: q);
      return (r.data['data'] as List).map((j) => PropertyPromotion.fromJson(j)).toList();
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get with filters ──
  Future<List<PropertyPromotion>> getWithFilters({
    PropertyPromotionType? promotionType,
    PropertyPromotionStatus? status,
    DateTime? startDate,
    DateTime? endDate,
    double? price,
  }) async {
    final filters = <String, dynamic>{};
    if (promotionType != null) filters['promotionType'] = promotionType.toString();
    if (status != null) filters['status'] = status.toString();
    if (startDate != null) filters['startDate'] = startDate.toIso8601String();
    if (endDate != null) filters['endDate'] = endDate.toIso8601String();
    if (price != null) filters['price'] = price.toString();
    return getAll(filters: filters);
  }

  // ── Create ──
  Future<PropertyPromotion> create(PropertyPromotion propertyPromotion) async {

    try {
      final r = await _dioClient.post('/propertyPromotion', data: propertyPromotion.toJson());
      return PropertyPromotion.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Update ──
  Future<PropertyPromotion> update(String id, PropertyPromotion propertyPromotion) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.put('/propertyPromotion/$id', data: propertyPromotion.toJson());
      return PropertyPromotion.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Delete ──
  Future<void> delete(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      await _dioClient.delete('/propertyPromotion/$id');
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