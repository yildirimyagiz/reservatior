import 'package:dio/dio.dart';
import '../../../core/network/dio_client.dart';
import '../../../gen_models/models_library.dart';

class PropertyService {
  final DioClient _dioClient;
  PropertyService(this._dioClient);

  // ── Get by ID ──
  Future<Property> getById(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.get('/property/$id');
      return Property.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get all ──
  Future<List<Property>> getAll({
    int page = 1, int limit = 20,
    Map<String, dynamic>? filters,
  }) async {
    try {
      final q = <String, dynamic>{'page': page.toString(), 'limit': limit.toString()};
      if (filters != null) q.addAll(filters);
      final r = await _dioClient.get('/property', queryParameters: q);
      return (r.data['data'] as List).map((j) => Property.fromJson(j)).toList();
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get with filters ──
  Future<List<Property>> getWithFilters({
    PropertyType? type,
    String? name,
    Region? region,
    String? currency,
    String? addressLine1,
  }) async {
    final filters = <String, dynamic>{};
    if (type != null) filters['type'] = type.toString();
    if (name != null) filters['name'] = name;
    if (region != null) filters['region'] = region.toString();
    if (currency != null) filters['currency'] = currency;
    if (addressLine1 != null) filters['addressLine1'] = addressLine1;
    return getAll(filters: filters);
  }

  // ── Create ──
  Future<Property> create(Property property) async {
    if (property.type == null || property.type!.isEmpty) {
      throw ArgumentError('type is required');
    }
    if (property.name == null || property.name!.isEmpty) {
      throw ArgumentError('name is required');
    }
    try {
      final r = await _dioClient.post('/property', data: property.toJson());
      return Property.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Update ──
  Future<Property> update(String id, Property property) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.put('/property/$id', data: property.toJson());
      return Property.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Delete ──
  Future<void> delete(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      await _dioClient.delete('/property/$id');
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