import 'package:dio/dio.dart';
import '../../../core/network/dio_client.dart';
import '../../../gen_models/models_library.dart';

class SharedAmenityService {
  final DioClient _dioClient;
  SharedAmenityService(this._dioClient);

  // ── Get by ID ──
  Future<SharedAmenity> getById(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.get('/sharedAmenity/$id');
      return SharedAmenity.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get all ──
  Future<List<SharedAmenity>> getAll({
    int page = 1, int limit = 20,
    Map<String, dynamic>? filters,
  }) async {
    try {
      final q = <String, dynamic>{'page': page.toString(), 'limit': limit.toString()};
      if (filters != null) q.addAll(filters);
      final r = await _dioClient.get('/sharedAmenity', queryParameters: q);
      return (r.data['data'] as List).map((j) => SharedAmenity.fromJson(j)).toList();
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get with filters ──
  Future<List<SharedAmenity>> getWithFilters({
    String? name,
    SharedAmenityType? type,
    String? description,
    String? location,
    int? capacity,
  }) async {
    final filters = <String, dynamic>{};
    if (name != null) filters['name'] = name;
    if (type != null) filters['type'] = type.toString();
    if (description != null) filters['description'] = description;
    if (location != null) filters['location'] = location;
    if (capacity != null) filters['capacity'] = capacity.toString();
    return getAll(filters: filters);
  }

  // ── Create ──
  Future<SharedAmenity> create(SharedAmenity sharedAmenity) async {
    if (sharedAmenity.name == null || sharedAmenity.name!.isEmpty) {
      throw ArgumentError('name is required');
    }
    if (sharedAmenity.type == null || sharedAmenity.type!.isEmpty) {
      throw ArgumentError('type is required');
    }
    try {
      final r = await _dioClient.post('/sharedAmenity', data: sharedAmenity.toJson());
      return SharedAmenity.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Update ──
  Future<SharedAmenity> update(String id, SharedAmenity sharedAmenity) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.put('/sharedAmenity/$id', data: sharedAmenity.toJson());
      return SharedAmenity.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Delete ──
  Future<void> delete(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      await _dioClient.delete('/sharedAmenity/$id');
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