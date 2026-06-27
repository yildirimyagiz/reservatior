import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class ProjectAnalyticsService {
  final DioClient _dioClient;
  ProjectAnalyticsService(this._dioClient);

  Future<ProjectAnalytics> getProjectAnalyticsById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.projectAnalyticses}/$id');
    return ProjectAnalytics.fromJson(response.data['data']);
  }

  Future<List<ProjectAnalytics>> getProjectAnalyticses({
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
    final response = await _dioClient.get(ApiEndpoints.projectAnalyticses, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => ProjectAnalytics.fromJson(json)).toList();
  }

  Future<ProjectAnalytics> createProjectAnalytics(ProjectAnalytics item) async {
    final response = await _dioClient.post(ApiEndpoints.projectAnalyticses, data: item.toJson());
    return ProjectAnalytics.fromJson(response.data['data']);
  }

  Future<ProjectAnalytics> updateProjectAnalytics(String id, ProjectAnalytics item) async {
    final response = await _dioClient.patch('${ApiEndpoints.projectAnalyticses}/$id', data: item.toJson());
    return ProjectAnalytics.fromJson(response.data['data']);
  }

  Future<void> deleteProjectAnalytics(String id) async {
    await _dioClient.delete('${ApiEndpoints.projectAnalyticses}/$id');
  }
}
