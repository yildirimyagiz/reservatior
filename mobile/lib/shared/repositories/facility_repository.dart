import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/repository_exception.dart';

/// Repository for Facility operations
/// Provides CRUD operations with proper error handling and type safety
class FacilityRepository {
  final DioClient _dioClient;

  FacilityRepository(this._dioClient);

  /// Get Facility by ID
  /// Returns [Facility] if found, throws [RepositoryException] otherwise
  Future<Facility> getFacilityById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/facility/$id');
      if (response.statusCode == 200) {
        return Facility.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to fetch facility',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.notFound,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all facilities with pagination and filtering
  /// Returns list of [Facility] objects
  Future<List<Facility>> getfacilities({
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
      
      final response = await _dioClient.get('/api/v1/facility', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => Facility.fromJson(item)).toList();
      } else {
        throw RepositoryException(
          message: 'Failed to fetch facilities',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new Facility
  /// Returns created [Facility] object
  Future<Facility> createFacility(Facility facility) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/facility',
        data: facility.toJson(),
      );
      return Facility.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update Facility
  Future<Facility> updateFacility(String id, Facility facility) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/facility/$id',
        data: facility.toJson(),
      );
      return Facility.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete Facility
  Future<void> deleteFacility(String id) async {
    try {
      await _dioClient.delete('/api/v1/facility/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    // Implement error handling logic here
    return Exception('API Error: ${e.message}');
  }
}
