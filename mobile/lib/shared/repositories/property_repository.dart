import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/repository_exception.dart';

/// Repository for Property operations
/// Provides CRUD operations with proper error handling and type safety
class PropertyRepository {
  final DioClient _dioClient;

  PropertyRepository(this._dioClient);

  /// Get Property by ID
  /// Returns [Property] if found, throws [RepositoryException] otherwise
  Future<Property> getPropertyById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/property/$id');
      if (response.statusCode == 200) {
        return Property.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to fetch property',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.notFound,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all properties with pagination and filtering
  /// Returns list of [Property] objects
  Future<List<Property>> getproperties({
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
      
      final response = await _dioClient.get('/api/v1/property', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => Property.fromJson(item)).toList();
      } else {
        throw RepositoryException(
          message: 'Failed to fetch properties',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new Property
  /// Returns created [Property] object
  Future<Property> createProperty(Property property) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/property',
        data: property.toJson(),
      );
      return Property.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update Property
  Future<Property> updateProperty(String id, Property property) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/property/$id',
        data: property.toJson(),
      );
      return Property.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete Property
  Future<void> deleteProperty(String id) async {
    try {
      await _dioClient.delete('/api/v1/property/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    // Implement error handling logic here
    return Exception('API Error: ${e.message}');
  }
}
