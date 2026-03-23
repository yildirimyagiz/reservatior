import 'package:dio/dio.dart';
import '../../../core/network/dio_client.dart';
import '../../../gen_models/models_library.dart';

class DashboardWidgetService {
  final DioClient _dioClient;
  DashboardWidgetService(this._dioClient);

  // ── Get by ID ──
  Future<DashboardWidget> getById(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.get('/dashboardWidget/$id');
      return DashboardWidget.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get all ──
  Future<List<DashboardWidget>> getAll({
    int page = 1, int limit = 20,
    Map<String, dynamic>? filters,
  }) async {
    try {
      final q = <String, dynamic>{'page': page.toString(), 'limit': limit.toString()};
      if (filters != null) q.addAll(filters);
      final r = await _dioClient.get('/dashboardWidget', queryParameters: q);
      return (r.data['data'] as List).map((j) => DashboardWidget.fromJson(j)).toList();
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get with filters ──
  Future<List<DashboardWidget>> getWithFilters({
    WidgetType? widgetType,
    String? title,
    dynamic? config,
    dynamic? position,
  }) async {
    final filters = <String, dynamic>{};
    if (widgetType != null) filters['widgetType'] = widgetType.toString();
    if (title != null) filters['title'] = title;
    if (config != null) filters['config'] = config.toString();
    if (position != null) filters['position'] = position.toString();
    return getAll(filters: filters);
  }

  // ── Create ──
  Future<DashboardWidget> create(DashboardWidget dashboardWidget) async {
    if (dashboardWidget.title == null || dashboardWidget.title!.isEmpty) {
      throw ArgumentError('title is required');
    }
    try {
      final r = await _dioClient.post('/dashboardWidget', data: dashboardWidget.toJson());
      return DashboardWidget.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Update ──
  Future<DashboardWidget> update(String id, DashboardWidget dashboardWidget) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.put('/dashboardWidget/$id', data: dashboardWidget.toJson());
      return DashboardWidget.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Delete ──
  Future<void> delete(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      await _dioClient.delete('/dashboardWidget/$id');
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