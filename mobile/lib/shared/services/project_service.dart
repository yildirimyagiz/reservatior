import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class ProjectService {
  final DioClient _dioClient;

  ProjectService(this._dioClient);

  // Get Project by ID
  Future<Project> getProjectById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/project/$id');
      return Project.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all projects
  Future<List<Project>> getProjects({
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

      final response = await _dioClient.get('/api/v1/project', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => Project.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create Project
  Future<Project> createProject(Project project) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/project',
        data: project.toJson(),
      );
      return Project.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update Project
  Future<Project> updateProject(String id, Project project) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/project/$id',
        data: project.toJson(),
      );
      return Project.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete Project
  Future<void> deleteProject(String id) async {
    try {
      await _dioClient.delete('/api/v1/project/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
