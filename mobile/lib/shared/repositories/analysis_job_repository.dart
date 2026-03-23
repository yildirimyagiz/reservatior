import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/repository_exception.dart';

/// Repository for AnalysisJob operations
/// Provides CRUD operations with proper error handling and type safety
class AnalysisJobRepository {
  final DioClient _dioClient;

  AnalysisJobRepository(this._dioClient);

  /// Get AnalysisJob by ID
  /// Returns [AnalysisJob] if found, throws [RepositoryException] otherwise
  Future<AnalysisJob> getAnalysisJobById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/analysis_job/$id');
      if (response.statusCode == 200) {
        return AnalysisJob.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to fetch analysis_job',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.notFound,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all analysis_jobs with pagination and filtering
  /// Returns list of [AnalysisJob] objects
  Future<List<AnalysisJob>> getanalysis_jobs({
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
      
      final response = await _dioClient.get('/api/v1/analysis_job', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => AnalysisJob.fromJson(item)).toList();
      } else {
        throw RepositoryException(
          message: 'Failed to fetch analysis_jobs',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new AnalysisJob
  /// Returns created [AnalysisJob] object
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
    // Implement error handling logic here
    return Exception('API Error: ${e.message}');
  }
}
