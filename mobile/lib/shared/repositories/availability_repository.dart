import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/repository_exception.dart';

/// Repository for Availability operations
/// Provides CRUD operations with proper error handling and type safety
class AvailabilityRepository {
  final DioClient _dioClient;

  AvailabilityRepository(this._dioClient);

  /// Get Availability by ID
  /// Returns [Availability] if found, throws [RepositoryException] otherwise
  Future<Availability> getAvailabilityById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/availability/$id');
      if (response.statusCode == 200) {
        return Availability.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to fetch availability',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.notFound,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all availabilities with pagination and filtering
  /// Returns list of [Availability] objects
  Future<List<Availability>> getavailabilities({
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
      
      final response = await _dioClient.get('/api/v1/availability', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => Availability.fromJson(item)).toList();
      } else {
        throw RepositoryException(
          message: 'Failed to fetch availabilities',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new Availability
  /// Returns created [Availability] object
  Future<Availability> createAvailability(Availability availability) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/availability',
        data: availability.toJson(),
      );
      return Availability.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update Availability
  Future<Availability> updateAvailability(String id, Availability availability) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/availability/$id',
        data: availability.toJson(),
      );
      return Availability.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete Availability
  Future<void> deleteAvailability(String id) async {
    try {
      await _dioClient.delete('/api/v1/availability/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    // Implement error handling logic here
    return Exception('API Error: ${e.message}');
  }
}
