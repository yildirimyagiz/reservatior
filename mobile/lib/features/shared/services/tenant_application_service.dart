import 'package:dio/dio.dart';
import '../../../core/network/dio_client.dart';
import '../../../gen_models/models_library.dart';

class TenantApplicationService {
  final DioClient _dioClient;
  TenantApplicationService(this._dioClient);

  // ── Get by ID ──
  Future<TenantApplication> getById(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.get('/tenantApplication/$id');
      return TenantApplication.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get all ──
  Future<List<TenantApplication>> getAll({
    int page = 1, int limit = 20,
    Map<String, dynamic>? filters,
  }) async {
    try {
      final q = <String, dynamic>{'page': page.toString(), 'limit': limit.toString()};
      if (filters != null) q.addAll(filters);
      final r = await _dioClient.get('/tenantApplication', queryParameters: q);
      return (r.data['data'] as List).map((j) => TenantApplication.fromJson(j)).toList();
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get with filters ──
  Future<List<TenantApplication>> getWithFilters({
    ApplicationStatus? status,
    DateTime? submittedAt,
    DateTime? reviewedAt,
    String? reviewedBy,
    dynamic? applicationData,
  }) async {
    final filters = <String, dynamic>{};
    if (status != null) filters['status'] = status.toString();
    if (submittedAt != null) filters['submittedAt'] = submittedAt.toIso8601String();
    if (reviewedAt != null) filters['reviewedAt'] = reviewedAt.toIso8601String();
    if (reviewedBy != null) filters['reviewedBy'] = reviewedBy;
    if (applicationData != null) filters['applicationData'] = applicationData.toString();
    return getAll(filters: filters);
  }

  // ── Create ──
  Future<TenantApplication> create(TenantApplication tenantApplication) async {

    try {
      final r = await _dioClient.post('/tenantApplication', data: tenantApplication.toJson());
      return TenantApplication.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Update ──
  Future<TenantApplication> update(String id, TenantApplication tenantApplication) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.put('/tenantApplication/$id', data: tenantApplication.toJson());
      return TenantApplication.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Delete ──
  Future<void> delete(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      await _dioClient.delete('/tenantApplication/$id');
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