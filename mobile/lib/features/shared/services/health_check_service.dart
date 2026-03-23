import 'package:dio/dio.dart';
import '../../../core/network/dio_client.dart';
import '../../../gen_models/models_library.dart';

class HealthCheckService {
  final DioClient _dioClient;
  HealthCheckService(this._dioClient);

  // ── Get by ID ──
  Future<HealthCheck> getById(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.get('/healthCheck/$id');
      return HealthCheck.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get all ──
  Future<List<HealthCheck>> getAll({
    int page = 1, int limit = 20,
    Map<String, dynamic>? filters,
  }) async {
    try {
      final q = <String, dynamic>{'page': page.toString(), 'limit': limit.toString()};
      if (filters != null) q.addAll(filters);
      final r = await _dioClient.get('/healthCheck', queryParameters: q);
      return (r.data['data'] as List).map((j) => HealthCheck.fromJson(j)).toList();
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get with filters ──
  Future<List<HealthCheck>> getWithFilters({
    String? serviceName,
    String? componentName,
    String? status,
    int? responseTime,
    dynamic? details,
  }) async {
    final filters = <String, dynamic>{};
    if (serviceName != null) filters['serviceName'] = serviceName;
    if (componentName != null) filters['componentName'] = componentName;
    if (status != null) filters['status'] = status;
    if (responseTime != null) filters['responseTime'] = responseTime.toString();
    if (details != null) filters['details'] = details.toString();
    return getAll(filters: filters);
  }

  // ── Create ──
  Future<HealthCheck> create(HealthCheck healthCheck) async {

    try {
      final r = await _dioClient.post('/healthCheck', data: healthCheck.toJson());
      return HealthCheck.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Update ──
  Future<HealthCheck> update(String id, HealthCheck healthCheck) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.put('/healthCheck/$id', data: healthCheck.toJson());
      return HealthCheck.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Delete ──
  Future<void> delete(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      await _dioClient.delete('/healthCheck/$id');
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