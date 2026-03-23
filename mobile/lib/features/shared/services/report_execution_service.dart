import 'package:dio/dio.dart';
import '../../../core/network/dio_client.dart';
import '../../../gen_models/models_library.dart';

class ReportExecutionService {
  final DioClient _dioClient;
  ReportExecutionService(this._dioClient);

  // ── Get by ID ──
  Future<ReportExecution> getById(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.get('/reportExecution/$id');
      return ReportExecution.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get all ──
  Future<List<ReportExecution>> getAll({
    int page = 1, int limit = 20,
    Map<String, dynamic>? filters,
  }) async {
    try {
      final q = <String, dynamic>{'page': page.toString(), 'limit': limit.toString()};
      if (filters != null) q.addAll(filters);
      final r = await _dioClient.get('/reportExecution', queryParameters: q);
      return (r.data['data'] as List).map((j) => ReportExecution.fromJson(j)).toList();
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get with filters ──
  Future<List<ReportExecution>> getWithFilters({
    DateTime? executedAt,
    String? executedBy,
    String? status,
    String? resultUrl,
    String? errorMessage,
  }) async {
    final filters = <String, dynamic>{};
    if (executedAt != null) filters['executedAt'] = executedAt.toIso8601String();
    if (executedBy != null) filters['executedBy'] = executedBy;
    if (status != null) filters['status'] = status;
    if (resultUrl != null) filters['resultUrl'] = resultUrl;
    if (errorMessage != null) filters['errorMessage'] = errorMessage;
    return getAll(filters: filters);
  }

  // ── Create ──
  Future<ReportExecution> create(ReportExecution reportExecution) async {

    try {
      final r = await _dioClient.post('/reportExecution', data: reportExecution.toJson());
      return ReportExecution.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Update ──
  Future<ReportExecution> update(String id, ReportExecution reportExecution) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.put('/reportExecution/$id', data: reportExecution.toJson());
      return ReportExecution.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Delete ──
  Future<void> delete(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      await _dioClient.delete('/reportExecution/$id');
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