import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class ProjectService {
  final DioClient _dioClient;
  ProjectService(this._dioClient);

  Future<Project> getProjectById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.projects}/$id');
    return Project.fromJson(response.data['data']);
  }

  Future<List<Project>> getProjects({
    int page = 1, 
    int limit = 20, 
    String? orgId,
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) async {
    final queryParams = {
      'page': page, 
      'limit': limit,
      if (orgId != null) 'orgId': orgId,
      if (sortBy != null) 'sortBy': sortBy,
      if (sortOrder != null) 'sortOrder': sortOrder,
      ...?filters
    };
    final response = await _dioClient.get(ApiEndpoints.projects, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => Project.fromJson(json)).toList();
  }

  Future<Project> createProject(Project item) async {
    final response = await _dioClient.post(ApiEndpoints.projects, data: item.toJson());
    return Project.fromJson(response.data['data']);
  }

  Future<Project> updateProject(String id, Project item) async {
    final response = await _dioClient.patch('${ApiEndpoints.projects}/$id', data: item.toJson());
    return Project.fromJson(response.data['data']);
  }

  Future<void> deleteProject(String id) async {
    await _dioClient.delete('${ApiEndpoints.projects}/$id');
  }
}
