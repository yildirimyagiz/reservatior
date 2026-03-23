import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class DashboardWidgetService {
  final DioClient _dioClient;

  DashboardWidgetService(this._dioClient);

  // Get DashboardWidget by ID
  Future<DashboardWidget> getDashboardWidgetById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/dashboard_widget/$id');
      return DashboardWidget.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all dashboard_widgets
  Future<List<DashboardWidget>> getDashboardWidgets({
    int page = 1,
    int limit = 20,
    Map<String, dynamic>? filters,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'page': page.toString(),
        'limit': limit.toString(),
      };

      if (filters != null) {
        queryParams.addAll(filters);
      }

      final response = await _dioClient.get('/api/v1/dashboard_widget', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => DashboardWidget.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create DashboardWidget
  Future<DashboardWidget> createDashboardWidget(DashboardWidget dashboardWidget) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/dashboard_widget',
        data: dashboardWidget.toJson(),
      );
      return DashboardWidget.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update DashboardWidget
  Future<DashboardWidget> updateDashboardWidget(String id, DashboardWidget dashboardWidget) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/dashboard_widget/$id',
        data: dashboardWidget.toJson(),
      );
      return DashboardWidget.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete DashboardWidget
  Future<void> deleteDashboardWidget(String id) async {
    try {
      await _dioClient.delete('/api/v1/dashboard_widget/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
