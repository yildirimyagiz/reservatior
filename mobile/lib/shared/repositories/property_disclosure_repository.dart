import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/repository_exception.dart';

/// Repository for PropertyDisclosure operations
/// Provides CRUD operations with proper error handling and type safety
class PropertyDisclosureRepository {
  final DioClient _dioClient;

  PropertyDisclosureRepository(this._dioClient);

  /// Get PropertyDisclosure by ID
  /// Returns [PropertyDisclosure] if found, throws [RepositoryException] otherwise
  Future<PropertyDisclosure> getPropertyDisclosureById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/property_disclosure/$id');
      if (response.statusCode == 200) {
        return PropertyDisclosure.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to fetch property_disclosure',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.notFound,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all property_disclosures with pagination and filtering
  /// Returns list of [PropertyDisclosure] objects
  Future<List<PropertyDisclosure>> getproperty_disclosures({
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
      
      final response = await _dioClient.get('/api/v1/property_disclosure', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => PropertyDisclosure.fromJson(item)).toList();
      } else {
        throw RepositoryException(
          message: 'Failed to fetch property_disclosures',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new PropertyDisclosure
  /// Returns created [PropertyDisclosure] object
  Future<PropertyDisclosure> createPropertyDisclosure(PropertyDisclosure propertyDisclosure) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/property_disclosure',
        data: propertyDisclosure.toJson(),
      );
      return PropertyDisclosure.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update PropertyDisclosure
  Future<PropertyDisclosure> updatePropertyDisclosure(String id, PropertyDisclosure propertyDisclosure) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/property_disclosure/$id',
        data: propertyDisclosure.toJson(),
      );
      return PropertyDisclosure.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete PropertyDisclosure
  Future<void> deletePropertyDisclosure(String id) async {
    try {
      await _dioClient.delete('/api/v1/property_disclosure/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    // Implement error handling logic here
    return Exception('API Error: ${e.message}');
  }
}
