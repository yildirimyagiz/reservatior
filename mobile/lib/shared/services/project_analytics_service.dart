import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class ProjectAnalyticsService {
  final DioClient _dioClient;

  ProjectAnalyticsService(this._dioClient);

  // Get ProjectAnalytics by ID
  Future<ProjectAnalytics> getProjectAnalyticsById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/project_analytics/$id');
      return ProjectAnalytics.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all project_analyticss
  Future<List<ProjectAnalytics>> getProjectAnalyticss({
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

      final response = await _dioClient.get('/api/v1/project_analytics', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => ProjectAnalytics.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create ProjectAnalytics
  Future<ProjectAnalytics> createProjectAnalytics(ProjectAnalytics projectAnalytics) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/project_analytics',
        data: projectAnalytics.toJson(),
      );
      return ProjectAnalytics.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update ProjectAnalytics
  Future<ProjectAnalytics> updateProjectAnalytics(String id, ProjectAnalytics projectAnalytics) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/project_analytics/$id',
        data: projectAnalytics.toJson(),
      );
      return ProjectAnalytics.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete ProjectAnalytics
  Future<void> deleteProjectAnalytics(String id) async {
    try {
      await _dioClient.delete('/api/v1/project_analytics/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
