import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/repository_exception.dart';

/// Repository for Job operations
/// Provides CRUD operations with proper error handling and type safety
class JobRepository {
  final DioClient _dioClient;

  JobRepository(this._dioClient);

  /// Get Job by ID
  /// Returns [Job] if found, throws [RepositoryException] otherwise
  Future<Job> getJobById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/job/$id');
      if (response.statusCode == 200) {
        return Job.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to fetch job',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.notFound,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all jobs with pagination and filtering
  /// Returns list of [Job] objects
  Future<List<Job>> getjobs({
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
      
      final response = await _dioClient.get('/api/v1/job', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => Job.fromJson(item)).toList();
      } else {
        throw RepositoryException(
          message: 'Failed to fetch jobs',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new Job
  /// Returns created [Job] object
  Future<Job> createJob(Job job) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/job',
        data: job.toJson(),
      );
      return Job.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update Job
  Future<Job> updateJob(String id, Job job) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/job/$id',
        data: job.toJson(),
      );
      return Job.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete Job
  Future<void> deleteJob(String id) async {
    try {
      await _dioClient.delete('/api/v1/job/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    // Implement error handling logic here
    return Exception('API Error: ${e.message}');
  }
}
