import 'package:dio/dio.dart';
import '../../../core/network/dio_client.dart';
import '../../../gen_models/models_library.dart';

class JobService {
  final DioClient _dioClient;
  JobService(this._dioClient);

  // ── Get by ID ──
  Future<Job> getById(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.get('/job/$id');
      return Job.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get all ──
  Future<List<Job>> getAll({
    int page = 1, int limit = 20,
    Map<String, dynamic>? filters,
  }) async {
    try {
      final q = <String, dynamic>{'page': page.toString(), 'limit': limit.toString()};
      if (filters != null) q.addAll(filters);
      final r = await _dioClient.get('/job', queryParameters: q);
      return (r.data['data'] as List).map((j) => Job.fromJson(j)).toList();
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get with filters ──
  Future<List<Job>> getWithFilters({
    String? type,
    dynamic? payload,
    ExportStatus? status,
    DateTime? runAt,
    int? attempts,
  }) async {
    final filters = <String, dynamic>{};
    if (type != null) filters['type'] = type;
    if (payload != null) filters['payload'] = payload.toString();
    if (status != null) filters['status'] = status.toString();
    if (runAt != null) filters['runAt'] = runAt.toIso8601String();
    if (attempts != null) filters['attempts'] = attempts.toString();
    return getAll(filters: filters);
  }

  // ── Create ──
  Future<Job> create(Job job) async {
    if (job.type == null || job.type!.isEmpty) {
      throw ArgumentError('type is required');
    }
    try {
      final r = await _dioClient.post('/job', data: job.toJson());
      return Job.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Update ──
  Future<Job> update(String id, Job job) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.put('/job/$id', data: job.toJson());
      return Job.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Delete ──
  Future<void> delete(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      await _dioClient.delete('/job/$id');
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