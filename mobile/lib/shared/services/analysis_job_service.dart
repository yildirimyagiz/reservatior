import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class AnalysisJobService {
  final DioClient _dioClient;
  AnalysisJobService(this._dioClient);

  Future<AnalysisJob> getAnalysisJobById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.analysisJobs}/$id');
    return AnalysisJob.fromJson(response.data['data']);
  }

  Future<List<AnalysisJob>> getAnalysisJobs({
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
    final response = await _dioClient.get(ApiEndpoints.analysisJobs, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => AnalysisJob.fromJson(json)).toList();
  }

  Future<AnalysisJob> createAnalysisJob(AnalysisJob item) async {
    final response = await _dioClient.post(ApiEndpoints.analysisJobs, data: item.toJson());
    return AnalysisJob.fromJson(response.data['data']);
  }

  Future<AnalysisJob> updateAnalysisJob(String id, AnalysisJob item) async {
    final response = await _dioClient.patch('${ApiEndpoints.analysisJobs}/$id', data: item.toJson());
    return AnalysisJob.fromJson(response.data['data']);
  }

  Future<void> deleteAnalysisJob(String id) async {
    await _dioClient.delete('${ApiEndpoints.analysisJobs}/$id');
  }
}
