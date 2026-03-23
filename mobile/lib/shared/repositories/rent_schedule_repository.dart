import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/repository_exception.dart';

/// Repository for RentSchedule operations
/// Provides CRUD operations with proper error handling and type safety
class RentScheduleRepository {
  final DioClient _dioClient;

  RentScheduleRepository(this._dioClient);

  /// Get RentSchedule by ID
  /// Returns [RentSchedule] if found, throws [RepositoryException] otherwise
  Future<RentSchedule> getRentScheduleById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/rent_schedule/$id');
      if (response.statusCode == 200) {
        return RentSchedule.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to fetch rent_schedule',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.notFound,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all rent_schedules with pagination and filtering
  /// Returns list of [RentSchedule] objects
  Future<List<RentSchedule>> getrent_schedules({
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
      
      final response = await _dioClient.get('/api/v1/rent_schedule', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => RentSchedule.fromJson(item)).toList();
      } else {
        throw RepositoryException(
          message: 'Failed to fetch rent_schedules',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new RentSchedule
  /// Returns created [RentSchedule] object
  Future<RentSchedule> createRentSchedule(RentSchedule rentSchedule) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/rent_schedule',
        data: rentSchedule.toJson(),
      );
      return RentSchedule.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update RentSchedule
  Future<RentSchedule> updateRentSchedule(String id, RentSchedule rentSchedule) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/rent_schedule/$id',
        data: rentSchedule.toJson(),
      );
      return RentSchedule.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete RentSchedule
  Future<void> deleteRentSchedule(String id) async {
    try {
      await _dioClient.delete('/api/v1/rent_schedule/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    // Implement error handling logic here
    return Exception('API Error: ${e.message}');
  }
}
