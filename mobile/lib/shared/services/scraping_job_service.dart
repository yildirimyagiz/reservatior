import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class ScrapingJobService {
  final DioClient _dioClient;

  ScrapingJobService(this._dioClient);

  // Get ScrapingJob by ID
  Future<ScrapingJob> getScrapingJobById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/scraping_job/$id');
      return ScrapingJob.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all scraping_jobs
  Future<List<ScrapingJob>> getScrapingJobs({
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

      final response = await _dioClient.get('/api/v1/scraping_job', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => ScrapingJob.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create ScrapingJob
  Future<ScrapingJob> createScrapingJob(ScrapingJob scrapingJob) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/scraping_job',
        data: scrapingJob.toJson(),
      );
      return ScrapingJob.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update ScrapingJob
  Future<ScrapingJob> updateScrapingJob(String id, ScrapingJob scrapingJob) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/scraping_job/$id',
        data: scrapingJob.toJson(),
      );
      return ScrapingJob.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete ScrapingJob
  Future<void> deleteScrapingJob(String id) async {
    try {
      await _dioClient.delete('/api/v1/scraping_job/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
