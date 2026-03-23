import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/repository_exception.dart';

/// Repository for MLSSyncJob operations
/// Provides CRUD operations with proper error handling and type safety
class MLSSyncJobRepository {
  final DioClient _dioClient;

  MLSSyncJobRepository(this._dioClient);

  /// Get MLSSyncJob by ID
  /// Returns [MLSSyncJob] if found, throws [RepositoryException] otherwise
  Future<MLSSyncJob> getMLSSyncJobById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/m_l_s_sync_job/$id');
      if (response.statusCode == 200) {
        return MLSSyncJob.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to fetch m_l_s_sync_job',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.notFound,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all m_l_s_sync_jobs with pagination and filtering
  /// Returns list of [MLSSyncJob] objects
  Future<List<MLSSyncJob>> getm_l_s_sync_jobs({
    int page = 1,
    int limit = 20,
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'page': page,
        'limit': limit,
        if (sortBy != null) 'sort_by': sortBy,
        if (sortOrder != null) 'sort_order': sortOrder,
        ...?filters,
      };
      
      final response = await _dioClient.get('/api/v1/m_l_s_sync_job', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => MLSSyncJob.fromJson(item)).toList();
      } else {
        throw RepositoryException(
          message: 'Failed to fetch m_l_s_sync_jobs',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new MLSSyncJob
  /// Returns created [MLSSyncJob] object
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
    // Implement error handling logic here
    return Exception('API Error: ${e.message}');
  }
}
