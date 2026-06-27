import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class ScrapingJobService {
  final DioClient _dioClient;
  ScrapingJobService(this._dioClient);

  Future<ScrapingJob> getScrapingJobById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.scrapingJobs}/$id');
    return ScrapingJob.fromJson(response.data['data']);
  }

  Future<List<ScrapingJob>> getScrapingJobs({
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
    final response = await _dioClient.get(ApiEndpoints.scrapingJobs, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => ScrapingJob.fromJson(json)).toList();
  }

  Future<ScrapingJob> createScrapingJob(ScrapingJob item) async {
    final response = await _dioClient.post(ApiEndpoints.scrapingJobs, data: item.toJson());
    return ScrapingJob.fromJson(response.data['data']);
  }

  Future<ScrapingJob> updateScrapingJob(String id, ScrapingJob item) async {
    final response = await _dioClient.patch('${ApiEndpoints.scrapingJobs}/$id', data: item.toJson());
    return ScrapingJob.fromJson(response.data['data']);
  }

  Future<void> deleteScrapingJob(String id) async {
    await _dioClient.delete('${ApiEndpoints.scrapingJobs}/$id');
  }
}
