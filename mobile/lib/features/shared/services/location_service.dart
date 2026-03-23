import 'package:dio/dio.dart';
import '../../../core/network/dio_client.dart';
import '../../../gen_models/models_library.dart';

class LocationService {
  final DioClient _dioClient;
  LocationService(this._dioClient);

  // ── Get by ID ──
  Future<Location> getById(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.get('/location/$id');
      return Location.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get all ──
  Future<List<Location>> getAll({
    int page = 1, int limit = 20,
    Map<String, dynamic>? filters,
  }) async {
    try {
      final q = <String, dynamic>{'page': page.toString(), 'limit': limit.toString()};
      if (filters != null) q.addAll(filters);
      final r = await _dioClient.get('/location', queryParameters: q);
      return (r.data['data'] as List).map((j) => Location.fromJson(j)).toList();
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get with filters ──
  Future<List<Location>> getWithFilters({
    String? addressLine1,
    String? addressLine2,
    String? addressLine3,
    String? city,
    String? state,
  }) async {
    final filters = <String, dynamic>{};
    if (addressLine1 != null) filters['addressLine1'] = addressLine1;
    if (addressLine2 != null) filters['addressLine2'] = addressLine2;
    if (addressLine3 != null) filters['addressLine3'] = addressLine3;
    if (city != null) filters['city'] = city;
    if (state != null) filters['state'] = state;
    return getAll(filters: filters);
  }

  // ── Create ──
  Future<Location> create(Location location) async {
    if (location.title == null || location.title!.isEmpty) {
      throw ArgumentError('title is required');
    }
    try {
      final r = await _dioClient.post('/location', data: location.toJson());
      return Location.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Update ──
  Future<Location> update(String id, Location location) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.put('/location/$id', data: location.toJson());
      return Location.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Delete ──
  Future<void> delete(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      await _dioClient.delete('/location/$id');
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