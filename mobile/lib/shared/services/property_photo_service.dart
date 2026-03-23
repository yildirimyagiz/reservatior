import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class PropertyPhotoService {
  final DioClient _dioClient;

  PropertyPhotoService(this._dioClient);

  // Get PropertyPhoto by ID
  Future<PropertyPhoto> getPropertyPhotoById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/property_photo/$id');
      return PropertyPhoto.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all property_photos
  Future<List<PropertyPhoto>> getPropertyPhotos({
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

      final response = await _dioClient.get('/api/v1/property_photo', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => PropertyPhoto.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create PropertyPhoto
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
    return Exception('API Error: ${e.message}');
  }
}
