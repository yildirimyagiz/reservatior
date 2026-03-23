import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/repository_exception.dart';

/// Repository for Photo operations
/// Provides CRUD operations with proper error handling and type safety
class PhotoRepository {
  final DioClient _dioClient;

  PhotoRepository(this._dioClient);

  /// Get Photo by ID
  /// Returns [Photo] if found, throws [RepositoryException] otherwise
  Future<Photo> getPhotoById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/photo/$id');
      if (response.statusCode == 200) {
        return Photo.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to fetch photo',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.notFound,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all photos with pagination and filtering
  /// Returns list of [Photo] objects
  Future<List<Photo>> getphotos({
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
      
      final response = await _dioClient.get('/api/v1/photo', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => Photo.fromJson(item)).toList();
      } else {
        throw RepositoryException(
          message: 'Failed to fetch photos',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new Photo
  /// Returns created [Photo] object
  Future<Photo> createPhoto(Photo photo) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/photo',
        data: photo.toJson(),
      );
      return Photo.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update Photo
  Future<Photo> updatePhoto(String id, Photo photo) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/photo/$id',
        data: photo.toJson(),
      );
      return Photo.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete Photo
  Future<void> deletePhoto(String id) async {
    try {
      await _dioClient.delete('/api/v1/photo/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    // Implement error handling logic here
    return Exception('API Error: ${e.message}');
  }
}
