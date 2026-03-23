import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/repository_exception.dart';

/// Repository for Amenity operations
/// Provides CRUD operations with proper error handling and type safety
class AmenityRepository {
  final DioClient _dioClient;

  AmenityRepository(this._dioClient);

  /// Get Amenity by ID
  /// Returns [Amenity] if found, throws [RepositoryException] otherwise
  Future<Amenity> getAmenityById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/amenity/$id');
      if (response.statusCode == 200) {
        return Amenity.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to fetch amenity',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.notFound,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all amenities with pagination and filtering
  /// Returns list of [Amenity] objects
  Future<List<Amenity>> getamenities({
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
      
      final response = await _dioClient.get('/api/v1/amenity', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => Amenity.fromJson(item)).toList();
      } else {
        throw RepositoryException(
          message: 'Failed to fetch amenities',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new Amenity
  /// Returns created [Amenity] object
  Future<Amenity> createAmenity(Amenity amenity) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/amenity',
        data: amenity.toJson(),
      );
      return Amenity.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update Amenity
  Future<Amenity> updateAmenity(String id, Amenity amenity) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/amenity/$id',
        data: amenity.toJson(),
      );
      return Amenity.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete Amenity
  Future<void> deleteAmenity(String id) async {
    try {
      await _dioClient.delete('/api/v1/amenity/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    // Implement error handling logic here
    return Exception('API Error: ${e.message}');
  }
}
