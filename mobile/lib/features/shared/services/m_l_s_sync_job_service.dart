import 'package:dio/dio.dart';
import '../../../core/network/dio_client.dart';
import '../../../gen_models/models_library.dart';

class MLSSyncJobService {
  final DioClient _dioClient;
  MLSSyncJobService(this._dioClient);

  // ── Get by ID ──
  Future<MLSSyncJob> getById(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.get('/mLSSyncJob/$id');
      return MLSSyncJob.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get all ──
  Future<List<MLSSyncJob>> getAll({
    int page = 1, int limit = 20,
    Map<String, dynamic>? filters,
  }) async {
    try {
      final q = <String, dynamic>{'page': page.toString(), 'limit': limit.toString()};
      if (filters != null) q.addAll(filters);
      final r = await _dioClient.get('/mLSSyncJob', queryParameters: q);
      return (r.data['data'] as List).map((j) => MLSSyncJob.fromJson(j)).toList();
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get with filters ──
  Future<List<MLSSyncJob>> getWithFilters({
    SyncStatus? status,
    DateTime? startedAt,
    DateTime? finishedAt,
    String? error,
    dynamic? stats,
  }) async {
    final filters = <String, dynamic>{};
    if (status != null) filters['status'] = status.toString();
    if (startedAt != null) filters['startedAt'] = startedAt.toIso8601String();
    if (finishedAt != null) filters['finishedAt'] = finishedAt.toIso8601String();
    if (error != null) filters['error'] = error;
    if (stats != null) filters['stats'] = stats.toString();
    return getAll(filters: filters);
  }

  // ── Create ──
  Future<MLSSyncJob> create(MLSSyncJob mLSSyncJob) async {

    try {
      final r = await _dioClient.post('/mLSSyncJob', data: mLSSyncJob.toJson());
      return MLSSyncJob.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Update ──
  Future<MLSSyncJob> update(String id, MLSSyncJob mLSSyncJob) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.put('/mLSSyncJob/$id', data: mLSSyncJob.toJson());
      return MLSSyncJob.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Delete ──
  Future<void> delete(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      await _dioClient.delete('/mLSSyncJob/$id');
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