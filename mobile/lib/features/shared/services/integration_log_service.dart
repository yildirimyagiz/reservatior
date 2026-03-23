import 'package:dio/dio.dart';
import '../../../core/network/dio_client.dart';
import '../../../gen_models/models_library.dart';

class IntegrationLogService {
  final DioClient _dioClient;
  IntegrationLogService(this._dioClient);

  // ── Get by ID ──
  Future<IntegrationLog> getById(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.get('/integrationLog/$id');
      return IntegrationLog.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get all ──
  Future<List<IntegrationLog>> getAll({
    int page = 1, int limit = 20,
    Map<String, dynamic>? filters,
  }) async {
    try {
      final q = <String, dynamic>{'page': page.toString(), 'limit': limit.toString()};
      if (filters != null) q.addAll(filters);
      final r = await _dioClient.get('/integrationLog', queryParameters: q);
      return (r.data['data'] as List).map((j) => IntegrationLog.fromJson(j)).toList();
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get with filters ──
  Future<List<IntegrationLog>> getWithFilters({
    String? integrationType,
    String? operation,
    dynamic? requestData,
    dynamic? responseData,
    int? statusCode,
  }) async {
    final filters = <String, dynamic>{};
    if (integrationType != null) filters['integrationType'] = integrationType;
    if (operation != null) filters['operation'] = operation;
    if (requestData != null) filters['requestData'] = requestData.toString();
    if (responseData != null) filters['responseData'] = responseData.toString();
    if (statusCode != null) filters['statusCode'] = statusCode.toString();
    return getAll(filters: filters);
  }

  // ── Create ──
  Future<IntegrationLog> create(IntegrationLog integrationLog) async {

    try {
      final r = await _dioClient.post('/integrationLog', data: integrationLog.toJson());
      return IntegrationLog.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Update ──
  Future<IntegrationLog> update(String id, IntegrationLog integrationLog) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.put('/integrationLog/$id', data: integrationLog.toJson());
      return IntegrationLog.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Delete ──
  Future<void> delete(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      await _dioClient.delete('/integrationLog/$id');
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