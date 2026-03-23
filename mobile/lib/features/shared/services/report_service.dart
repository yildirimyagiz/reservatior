import 'package:dio/dio.dart';
import '../../../core/network/dio_client.dart';
import '../../../gen_models/models_library.dart';

class ReportService {
  final DioClient _dioClient;
  ReportService(this._dioClient);

  // ── Get by ID ──
  Future<Report> getById(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.get('/report/$id');
      return Report.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get all ──
  Future<List<Report>> getAll({
    int page = 1, int limit = 20,
    Map<String, dynamic>? filters,
  }) async {
    try {
      final q = <String, dynamic>{'page': page.toString(), 'limit': limit.toString()};
      if (filters != null) q.addAll(filters);
      final r = await _dioClient.get('/report', queryParameters: q);
      return (r.data['data'] as List).map((j) => Report.fromJson(j)).toList();
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get with filters ──
  Future<List<Report>> getWithFilters({
    String? name,
    String? description,
    String? reportType,
    dynamic? config,
    dynamic? schedule,
  }) async {
    final filters = <String, dynamic>{};
    if (name != null) filters['name'] = name;
    if (description != null) filters['description'] = description;
    if (reportType != null) filters['reportType'] = reportType;
    if (config != null) filters['config'] = config.toString();
    if (schedule != null) filters['schedule'] = schedule.toString();
    return getAll(filters: filters);
  }

  // ── Create ──
  Future<Report> create(Report report) async {
    if (report.name == null || report.name!.isEmpty) {
      throw ArgumentError('name is required');
    }
    try {
      final r = await _dioClient.post('/report', data: report.toJson());
      return Report.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Update ──
  Future<Report> update(String id, Report report) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.put('/report/$id', data: report.toJson());
      return Report.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Delete ──
  Future<void> delete(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      await _dioClient.delete('/report/$id');
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