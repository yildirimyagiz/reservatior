import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/repository_exception.dart';

/// Repository for PropertyPhoto operations
/// Provides CRUD operations with proper error handling and type safety
class PropertyPhotoRepository {
  final DioClient _dioClient;

  PropertyPhotoRepository(this._dioClient);

  /// Get PropertyPhoto by ID
  /// Returns [PropertyPhoto] if found, throws [RepositoryException] otherwise
  Future<PropertyPhoto> getPropertyPhotoById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/property_photo/$id');
      if (response.statusCode == 200) {
        return PropertyPhoto.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to fetch property_photo',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.notFound,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all property_photos with pagination and filtering
  /// Returns list of [PropertyPhoto] objects
  Future<List<PropertyPhoto>> getproperty_photos({
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
      
      final response = await _dioClient.get('/api/v1/property_photo', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => PropertyPhoto.fromJson(item)).toList();
      } else {
        throw RepositoryException(
          message: 'Failed to fetch property_photos',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new PropertyPhoto
  /// Returns created [PropertyPhoto] object
  Future<PropertyPhoto> createPropertyPhoto(PropertyPhoto propertyPhoto) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/property_photo',
        data: propertyPhoto.toJson(),
      );
      return PropertyPhoto.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update PropertyPhoto
  Future<PropertyPhoto> updatePropertyPhoto(String id, PropertyPhoto propertyPhoto) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/property_photo/$id',
        data: propertyPhoto.toJson(),
      );
      return PropertyPhoto.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete PropertyPhoto
  Future<void> deletePropertyPhoto(String id) async {
    try {
      await _dioClient.delete('/api/v1/property_photo/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    // Implement error handling logic here
    return Exception('API Error: ${e.message}');
  }
}
