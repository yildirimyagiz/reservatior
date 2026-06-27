import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class JobService {
  final DioClient _dioClient;
  JobService(this._dioClient);

  Future<Job> getJobById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.jobs}/$id');
    return Job.fromJson(response.data['data']);
  }

  Future<List<Job>> getJobs({
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
    final response = await _dioClient.get(ApiEndpoints.jobs, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => Job.fromJson(json)).toList();
  }

  Future<Job> createJob(Job item) async {
    final response = await _dioClient.post(ApiEndpoints.jobs, data: item.toJson());
    return Job.fromJson(response.data['data']);
  }

  Future<Job> updateJob(String id, Job item) async {
    final response = await _dioClient.patch('${ApiEndpoints.jobs}/$id', data: item.toJson());
    return Job.fromJson(response.data['data']);
  }

  Future<void> deleteJob(String id) async {
    await _dioClient.delete('${ApiEndpoints.jobs}/$id');
  }
}
