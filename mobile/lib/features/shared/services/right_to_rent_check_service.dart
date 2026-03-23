import 'package:dio/dio.dart';
import '../../../core/network/dio_client.dart';
import '../../../gen_models/models_library.dart';

class RightToRentCheckService {
  final DioClient _dioClient;
  RightToRentCheckService(this._dioClient);

  // ── Get by ID ──
  Future<RightToRentCheck> getById(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.get('/rightToRentCheck/$id');
      return RightToRentCheck.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get all ──
  Future<List<RightToRentCheck>> getAll({
    int page = 1, int limit = 20,
    Map<String, dynamic>? filters,
  }) async {
    try {
      final q = <String, dynamic>{'page': page.toString(), 'limit': limit.toString()};
      if (filters != null) q.addAll(filters);
      final r = await _dioClient.get('/rightToRentCheck', queryParameters: q);
      return (r.data['data'] as List).map((j) => RightToRentCheck.fromJson(j)).toList();
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get with filters ──
  Future<List<RightToRentCheck>> getWithFilters({
    String? checkType,
    String? reference,
    String? status,
    DateTime? checkedAt,
    DateTime? expiresAt,
  }) async {
    final filters = <String, dynamic>{};
    if (checkType != null) filters['checkType'] = checkType;
    if (reference != null) filters['reference'] = reference;
    if (status != null) filters['status'] = status;
    if (checkedAt != null) filters['checkedAt'] = checkedAt.toIso8601String();
    if (expiresAt != null) filters['expiresAt'] = expiresAt.toIso8601String();
    return getAll(filters: filters);
  }

  // ── Create ──
  Future<RightToRentCheck> create(RightToRentCheck rightToRentCheck) async {

    try {
      final r = await _dioClient.post('/rightToRentCheck', data: rightToRentCheck.toJson());
      return RightToRentCheck.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Update ──
  Future<RightToRentCheck> update(String id, RightToRentCheck rightToRentCheck) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.put('/rightToRentCheck/$id', data: rightToRentCheck.toJson());
      return RightToRentCheck.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Delete ──
  Future<void> delete(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      await _dioClient.delete('/rightToRentCheck/$id');
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