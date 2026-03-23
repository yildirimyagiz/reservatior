import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class MLSSyncJobService {
  final DioClient _dioClient;

  MLSSyncJobService(this._dioClient);

  // Get MLSSyncJob by ID
  Future<MLSSyncJob> getMLSSyncJobById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/m_l_s_sync_job/$id');
      return MLSSyncJob.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all m_l_s_sync_jobs
  Future<List<MLSSyncJob>> getMLSSyncJobs({
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

      final response = await _dioClient.get('/api/v1/m_l_s_sync_job', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => MLSSyncJob.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create MLSSyncJob
  Future<MLSSyncJob> createMLSSyncJob(MLSSyncJob mLSSyncJob) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/m_l_s_sync_job',
        data: mLSSyncJob.toJson(),
      );
      return MLSSyncJob.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update MLSSyncJob
  Future<MLSSyncJob> updateMLSSyncJob(String id, MLSSyncJob mLSSyncJob) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/m_l_s_sync_job/$id',
        data: mLSSyncJob.toJson(),
      );
      return MLSSyncJob.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete MLSSyncJob
  Future<void> deleteMLSSyncJob(String id) async {
    try {
      await _dioClient.delete('/api/v1/m_l_s_sync_job/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
