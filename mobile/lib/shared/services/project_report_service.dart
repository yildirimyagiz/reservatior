import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class ProjectReportService {
  final DioClient _dioClient;

  ProjectReportService(this._dioClient);

  // Get ProjectReport by ID
  Future<ProjectReport> getProjectReportById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/project_report/$id');
      return ProjectReport.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all project_reports
  Future<List<ProjectReport>> getProjectReports({
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

      final response = await _dioClient.get('/api/v1/project_report', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => ProjectReport.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create ProjectReport
  Future<ProjectReport> createProjectReport(ProjectReport projectReport) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/project_report',
        data: projectReport.toJson(),
      );
      return ProjectReport.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update ProjectReport
  Future<ProjectReport> updateProjectReport(String id, ProjectReport projectReport) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/project_report/$id',
        data: projectReport.toJson(),
      );
      return ProjectReport.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete ProjectReport
  Future<void> deleteProjectReport(String id) async {
    try {
      await _dioClient.delete('/api/v1/project_report/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
