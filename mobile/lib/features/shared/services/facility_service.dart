import 'package:dio/dio.dart';
import '../../../core/network/dio_client.dart';
import '../../../gen_models/models_library.dart';

class FacilityService {
  final DioClient _dioClient;
  FacilityService(this._dioClient);

  // ── Get by ID ──
  Future<Facility> getById(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.get('/facility/$id');
      return Facility.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get all ──
  Future<List<Facility>> getAll({
    int page = 1, int limit = 20,
    Map<String, dynamic>? filters,
  }) async {
    try {
      final q = <String, dynamic>{'page': page.toString(), 'limit': limit.toString()};
      if (filters != null) q.addAll(filters);
      final r = await _dioClient.get('/facility', queryParameters: q);
      return (r.data['data'] as List).map((j) => Facility.fromJson(j)).toList();
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get with filters ──
  Future<List<Facility>> getWithFilters({
    String? name,
    double? feeAmount,
    String? feeCurrency,
    String? notes,
  }) async {
    final filters = <String, dynamic>{};
    if (name != null) filters['name'] = name;
    if (feeAmount != null) filters['feeAmount'] = feeAmount.toString();
    if (feeCurrency != null) filters['feeCurrency'] = feeCurrency;
    if (notes != null) filters['notes'] = notes;
    return getAll(filters: filters);
  }

  // ── Create ──
  Future<Facility> create(Facility facility) async {
    if (facility.name == null || facility.name!.isEmpty) {
      throw ArgumentError('name is required');
    }
    try {
      final r = await _dioClient.post('/facility', data: facility.toJson());
      return Facility.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Update ──
  Future<Facility> update(String id, Facility facility) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.put('/facility/$id', data: facility.toJson());
      return Facility.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Delete ──
  Future<void> delete(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      await _dioClient.delete('/facility/$id');
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