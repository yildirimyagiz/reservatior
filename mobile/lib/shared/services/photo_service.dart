import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class PhotoService {
  final DioClient _dioClient;

  PhotoService(this._dioClient);

  // Get Photo by ID
  Future<Photo> getPhotoById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/photo/$id');
      return Photo.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all photos
  Future<List<Photo>> getPhotos({
    int page = 1,
    int limit = 20,
    Map<String, dynamic>? filters,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'page': page.toString(),
        'limit': limit.toString(),
      };

      if (filters != null) {
        queryParams.addAll(filters);
      }

      final response = await _dioClient.get('/api/v1/photo', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => Photo.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create Photo
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
    return Exception('API Error: ${e.message}');
  }
}
