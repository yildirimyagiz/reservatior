import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class ProjectAlertService {
  final DioClient _dioClient;

  ProjectAlertService(this._dioClient);

  // Get ProjectAlert by ID
  Future<ProjectAlert> getProjectAlertById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/project_alert/$id');
      return ProjectAlert.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all project_alerts
  Future<List<ProjectAlert>> getProjectAlerts({
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

      final response = await _dioClient.get('/api/v1/project_alert', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => ProjectAlert.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create ProjectAlert
  Future<ProjectAlert> createProjectAlert(ProjectAlert projectAlert) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/project_alert',
        data: projectAlert.toJson(),
      );
      return ProjectAlert.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update ProjectAlert
  Future<ProjectAlert> updateProjectAlert(String id, ProjectAlert projectAlert) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/project_alert/$id',
        data: projectAlert.toJson(),
      );
      return ProjectAlert.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete ProjectAlert
  Future<void> deleteProjectAlert(String id) async {
    try {
      await _dioClient.delete('/api/v1/project_alert/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
