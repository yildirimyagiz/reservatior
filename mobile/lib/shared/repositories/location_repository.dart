import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/repository_exception.dart';

/// Repository for Location operations
/// Provides CRUD operations with proper error handling and type safety
class LocationRepository {
  final DioClient _dioClient;

  LocationRepository(this._dioClient);

  /// Get Location by ID
  /// Returns [Location] if found, throws [RepositoryException] otherwise
  Future<Location> getLocationById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/location/$id');
      if (response.statusCode == 200) {
        return Location.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to fetch location',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.notFound,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all locations with pagination and filtering
  /// Returns list of [Location] objects
  Future<List<Location>> getlocations({
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
      
      final response = await _dioClient.get('/api/v1/location', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => Location.fromJson(item)).toList();
      } else {
        throw RepositoryException(
          message: 'Failed to fetch locations',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new Location
  /// Returns created [Location] object
  Future<Location> createLocation(Location location) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/location',
        data: location.toJson(),
      );
      return Location.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update Location
  Future<Location> updateLocation(String id, Location location) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/location/$id',
        data: location.toJson(),
      );
      return Location.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete Location
  Future<void> deleteLocation(String id) async {
    try {
      await _dioClient.delete('/api/v1/location/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    // Implement error handling logic here
    return Exception('API Error: ${e.message}');
  }
}
