import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/repository_exception.dart';

/// Repository for PropertyViewing operations
/// Provides CRUD operations with proper error handling and type safety
class PropertyViewingRepository {
  final DioClient _dioClient;

  PropertyViewingRepository(this._dioClient);

  /// Get PropertyViewing by ID
  /// Returns [PropertyViewing] if found, throws [RepositoryException] otherwise
  Future<PropertyViewing> getPropertyViewingById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/property_viewing/$id');
      if (response.statusCode == 200) {
        return PropertyViewing.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to fetch property_viewing',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.notFound,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all property_viewings with pagination and filtering
  /// Returns list of [PropertyViewing] objects
  Future<List<PropertyViewing>> getproperty_viewings({
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
      
      final response = await _dioClient.get('/api/v1/property_viewing', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => PropertyViewing.fromJson(item)).toList();
      } else {
        throw RepositoryException(
          message: 'Failed to fetch property_viewings',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new PropertyViewing
  /// Returns created [PropertyViewing] object
  Future<PropertyViewing> createPropertyViewing(PropertyViewing propertyViewing) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/property_viewing',
        data: propertyViewing.toJson(),
      );
      return PropertyViewing.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update PropertyViewing
  Future<PropertyViewing> updatePropertyViewing(String id, PropertyViewing propertyViewing) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/property_viewing/$id',
        data: propertyViewing.toJson(),
      );
      return PropertyViewing.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete PropertyViewing
  Future<void> deletePropertyViewing(String id) async {
    try {
      await _dioClient.delete('/api/v1/property_viewing/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    // Implement error handling logic here
    return Exception('API Error: ${e.message}');
  }
}
