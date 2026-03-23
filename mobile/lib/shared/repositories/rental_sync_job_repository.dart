import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/repository_exception.dart';

/// Repository for RentalSyncJob operations
/// Provides CRUD operations with proper error handling and type safety
class RentalSyncJobRepository {
  final DioClient _dioClient;

  RentalSyncJobRepository(this._dioClient);

  /// Get RentalSyncJob by ID
  /// Returns [RentalSyncJob] if found, throws [RepositoryException] otherwise
  Future<RentalSyncJob> getRentalSyncJobById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/rental_sync_job/$id');
      if (response.statusCode == 200) {
        return RentalSyncJob.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to fetch rental_sync_job',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.notFound,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all rental_sync_jobs with pagination and filtering
  /// Returns list of [RentalSyncJob] objects
  Future<List<RentalSyncJob>> getrental_sync_jobs({
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
      
      final response = await _dioClient.get('/api/v1/rental_sync_job', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => RentalSyncJob.fromJson(item)).toList();
      } else {
        throw RepositoryException(
          message: 'Failed to fetch rental_sync_jobs',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new RentalSyncJob
  /// Returns created [RentalSyncJob] object
  Future<RentalSyncJob> createRentalSyncJob(RentalSyncJob rentalSyncJob) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/rental_sync_job',
        data: rentalSyncJob.toJson(),
      );
      return RentalSyncJob.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update RentalSyncJob
  Future<RentalSyncJob> updateRentalSyncJob(String id, RentalSyncJob rentalSyncJob) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/rental_sync_job/$id',
        data: rentalSyncJob.toJson(),
      );
      return RentalSyncJob.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete RentalSyncJob
  Future<void> deleteRentalSyncJob(String id) async {
    try {
      await _dioClient.delete('/api/v1/rental_sync_job/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    // Implement error handling logic here
    return Exception('API Error: ${e.message}');
  }
}
