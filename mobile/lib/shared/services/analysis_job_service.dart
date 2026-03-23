import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class AnalysisJobService {
  final DioClient _dioClient;

  AnalysisJobService(this._dioClient);

  // Get AnalysisJob by ID
  Future<AnalysisJob> getAnalysisJobById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/analysis_job/$id');
      return AnalysisJob.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all analysis_jobs
  Future<List<AnalysisJob>> getAnalysisJobs({
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

      final response = await _dioClient.get('/api/v1/analysis_job', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => AnalysisJob.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create AnalysisJob
  Future<AnalysisJob> createAnalysisJob(AnalysisJob analysisJob) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/analysis_job',
        data: analysisJob.toJson(),
      );
      return AnalysisJob.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update AnalysisJob
  Future<AnalysisJob> updateAnalysisJob(String id, AnalysisJob analysisJob) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/analysis_job/$id',
        data: analysisJob.toJson(),
      );
      return AnalysisJob.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete AnalysisJob
  Future<void> deleteAnalysisJob(String id) async {
    try {
      await _dioClient.delete('/api/v1/analysis_job/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
