import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/repository_exception.dart';

/// Repository for DashboardWidget operations
/// Provides CRUD operations with proper error handling and type safety
class DashboardWidgetRepository {
  final DioClient _dioClient;

  DashboardWidgetRepository(this._dioClient);

  /// Get DashboardWidget by ID
  /// Returns [DashboardWidget] if found, throws [RepositoryException] otherwise
  Future<DashboardWidget> getDashboardWidgetById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/dashboard_widget/$id');
      if (response.statusCode == 200) {
        return DashboardWidget.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to fetch dashboard_widget',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.notFound,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all dashboard_widgets with pagination and filtering
  /// Returns list of [DashboardWidget] objects
  Future<List<DashboardWidget>> getdashboard_widgets({
    int page = 1,
    int limit = 20,
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'page': page,
        'limit': limit,
        if (sortBy != null) 'sort_by': sortBy,
        if (sortOrder != null) 'sort_order': sortOrder,
        ...?filters,
      };
      
      final response = await _dioClient.get('/api/v1/dashboard_widget', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => DashboardWidget.fromJson(item)).toList();
      } else {
        throw RepositoryException(
          message: 'Failed to fetch dashboard_widgets',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new DashboardWidget
  /// Returns created [DashboardWidget] object
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
    // Implement error handling logic here
    return Exception('API Error: ${e.message}');
  }
}
