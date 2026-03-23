import 'package:dio/dio.dart';
import '../../../core/network/dio_client.dart';
import '../../../gen_models/models_library.dart';

class AgentAssignmentService {
  final DioClient _dioClient;
  AgentAssignmentService(this._dioClient);

  // ── Get by ID ──
  Future<AgentAssignment> getById(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.get('/agentAssignment/$id');
      return AgentAssignment.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get all ──
  Future<List<AgentAssignment>> getAll({
    int page = 1, int limit = 20,
    Map<String, dynamic>? filters,
  }) async {
    try {
      final q = <String, dynamic>{'page': page.toString(), 'limit': limit.toString()};
      if (filters != null) q.addAll(filters);
      final r = await _dioClient.get('/agentAssignment', queryParameters: q);
      return (r.data['data'] as List).map((j) => AgentAssignment.fromJson(j)).toList();
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get with filters ──
  Future<List<AgentAssignment>> getWithFilters({
    int? commissionBps,
  }) async {
    final filters = <String, dynamic>{};
    if (commissionBps != null) filters['commissionBps'] = commissionBps.toString();
    return getAll(filters: filters);
  }

  // ── Create ──
  Future<AgentAssignment> create(AgentAssignment agentAssignment) async {

    try {
      final r = await _dioClient.post('/agentAssignment', data: agentAssignment.toJson());
      return AgentAssignment.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Update ──
  Future<AgentAssignment> update(String id, AgentAssignment agentAssignment) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.put('/agentAssignment/$id', data: agentAssignment.toJson());
      return AgentAssignment.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Delete ──
  Future<void> delete(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      await _dioClient.delete('/agentAssignment/$id');
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