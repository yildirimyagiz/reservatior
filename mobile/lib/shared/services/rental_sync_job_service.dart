import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class RentalSyncJobService {
  final DioClient _dioClient;

  RentalSyncJobService(this._dioClient);

  // Get RentalSyncJob by ID
  Future<RentalSyncJob> getRentalSyncJobById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/rental_sync_job/$id');
      return RentalSyncJob.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all rental_sync_jobs
  Future<List<RentalSyncJob>> getRentalSyncJobs({
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

      final response = await _dioClient.get('/api/v1/rental_sync_job', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => RentalSyncJob.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create RentalSyncJob
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
    return Exception('API Error: ${e.message}');
  }
}
