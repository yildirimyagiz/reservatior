import 'package:dio/dio.dart';
import '../../../core/network/dio_client.dart';
import '../../../gen_models/models_library.dart';

class AutomationExecutionService {
  final DioClient _dioClient;
  AutomationExecutionService(this._dioClient);

  // ── Get by ID ──
  Future<AutomationExecution> getById(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.get('/automationExecution/$id');
      return AutomationExecution.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get all ──
  Future<List<AutomationExecution>> getAll({
    int page = 1, int limit = 20,
    Map<String, dynamic>? filters,
  }) async {
    try {
      final q = <String, dynamic>{'page': page.toString(), 'limit': limit.toString()};
      if (filters != null) q.addAll(filters);
      final r = await _dioClient.get('/automationExecution', queryParameters: q);
      return (r.data['data'] as List).map((j) => AutomationExecution.fromJson(j)).toList();
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get with filters ──
  Future<List<AutomationExecution>> getWithFilters({
    dynamic? triggerEvent,
    dynamic? executionData,
    String? status,
    DateTime? executedAt,
    int? processingTimeMs,
  }) async {
    final filters = <String, dynamic>{};
    if (triggerEvent != null) filters['triggerEvent'] = triggerEvent.toString();
    if (executionData != null) filters['executionData'] = executionData.toString();
    if (status != null) filters['status'] = status;
    if (executedAt != null) filters['executedAt'] = executedAt.toIso8601String();
    if (processingTimeMs != null) filters['processingTimeMs'] = processingTimeMs.toString();
    return getAll(filters: filters);
  }

  // ── Create ──
  Future<AutomationExecution> create(AutomationExecution automationExecution) async {

    try {
      final r = await _dioClient.post('/automationExecution', data: automationExecution.toJson());
      return AutomationExecution.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Update ──
  Future<AutomationExecution> update(String id, AutomationExecution automationExecution) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.put('/automationExecution/$id', data: automationExecution.toJson());
      return AutomationExecution.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Delete ──
  Future<void> delete(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      await _dioClient.delete('/automationExecution/$id');
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