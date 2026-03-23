import 'package:dio/dio.dart';
import '../../../core/network/dio_client.dart';
import '../../../gen_models/models_library.dart';

class FacilityBlockService {
  final DioClient _dioClient;
  FacilityBlockService(this._dioClient);

  // ── Get by ID ──
  Future<FacilityBlock> getById(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.get('/facilityBlock/$id');
      return FacilityBlock.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get all ──
  Future<List<FacilityBlock>> getAll({
    int page = 1, int limit = 20,
    Map<String, dynamic>? filters,
  }) async {
    try {
      final q = <String, dynamic>{'page': page.toString(), 'limit': limit.toString()};
      if (filters != null) q.addAll(filters);
      final r = await _dioClient.get('/facilityBlock', queryParameters: q);
      return (r.data['data'] as List).map((j) => FacilityBlock.fromJson(j)).toList();
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get with filters ──
  Future<List<FacilityBlock>> getWithFilters({
    String? name,
    int? floors,
    int? unitsPerFloor,
    int? totalUnits,
    int? yearBuilt,
  }) async {
    final filters = <String, dynamic>{};
    if (name != null) filters['name'] = name;
    if (floors != null) filters['floors'] = floors.toString();
    if (unitsPerFloor != null) filters['unitsPerFloor'] = unitsPerFloor.toString();
    if (totalUnits != null) filters['totalUnits'] = totalUnits.toString();
    if (yearBuilt != null) filters['yearBuilt'] = yearBuilt.toString();
    return getAll(filters: filters);
  }

  // ── Create ──
  Future<FacilityBlock> create(FacilityBlock facilityBlock) async {
    if (facilityBlock.name == null || facilityBlock.name!.isEmpty) {
      throw ArgumentError('name is required');
    }
    try {
      final r = await _dioClient.post('/facilityBlock', data: facilityBlock.toJson());
      return FacilityBlock.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Update ──
  Future<FacilityBlock> update(String id, FacilityBlock facilityBlock) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.put('/facilityBlock/$id', data: facilityBlock.toJson());
      return FacilityBlock.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Delete ──
  Future<void> delete(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      await _dioClient.delete('/facilityBlock/$id');
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