import 'package:dio/dio.dart';
import '../../../core/network/dio_client.dart';
import '../../../gen_models/models_library.dart';

class AIModelDeploymentService {
  final DioClient _dioClient;
  AIModelDeploymentService(this._dioClient);

  // ── Get by ID ──
  Future<AIModelDeployment> getById(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.get('/aIModelDeployment/$id');
      return AIModelDeployment.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get all ──
  Future<List<AIModelDeployment>> getAll({
    int page = 1, int limit = 20,
    Map<String, dynamic>? filters,
  }) async {
    try {
      final q = <String, dynamic>{'page': page.toString(), 'limit': limit.toString()};
      if (filters != null) q.addAll(filters);
      final r = await _dioClient.get('/aIModelDeployment', queryParameters: q);
      return (r.data['data'] as List).map((j) => AIModelDeployment.fromJson(j)).toList();
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get with filters ──
  Future<List<AIModelDeployment>> getWithFilters({
    String? environment,
    String? status,
    DateTime? deployedAt,
    DateTime? lastHealthCheck,
    dynamic? config,
  }) async {
    final filters = <String, dynamic>{};
    if (environment != null) filters['environment'] = environment;
    if (status != null) filters['status'] = status;
    if (deployedAt != null) filters['deployedAt'] = deployedAt.toIso8601String();
    if (lastHealthCheck != null) filters['lastHealthCheck'] = lastHealthCheck.toIso8601String();
    if (config != null) filters['config'] = config.toString();
    return getAll(filters: filters);
  }

  // ── Create ──
  Future<AIModelDeployment> create(AIModelDeployment aiModelDeployment) async {

    try {
      final r = await _dioClient.post('/aIModelDeployment', data: aiModelDeployment.toJson());
      return AIModelDeployment.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Update ──
  Future<AIModelDeployment> update(String id, AIModelDeployment aiModelDeployment) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.put('/aIModelDeployment/$id', data: aiModelDeployment.toJson());
      return AIModelDeployment.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Delete ──
  Future<void> delete(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      await _dioClient.delete('/aIModelDeployment/$id');
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