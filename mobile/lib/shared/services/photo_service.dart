import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class PhotoService {
  final DioClient _dioClient;
  PhotoService(this._dioClient);

  Future<Photo> getPhotoById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.photos}/$id');
    return Photo.fromJson(response.data['data']);
  }

  Future<List<Photo>> getPhotos({
    int page = 1, 
    int limit = 20, 
    String? orgId,
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) async {
    final queryParams = {
      'page': page, 
      'limit': limit,
      if (orgId != null) 'orgId': orgId,
      if (sortBy != null) 'sortBy': sortBy,
      if (sortOrder != null) 'sortOrder': sortOrder,
      ...?filters
    };
    final response = await _dioClient.get(ApiEndpoints.photos, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => Photo.fromJson(json)).toList();
  }

  Future<Photo> createPhoto(Photo item) async {
    final response = await _dioClient.post(ApiEndpoints.photos, data: item.toJson());
    return Photo.fromJson(response.data['data']);
  }

  Future<Photo> updatePhoto(String id, Photo item) async {
    final response = await _dioClient.patch('${ApiEndpoints.photos}/$id', data: item.toJson());
    return Photo.fromJson(response.data['data']);
  }

  Future<void> deletePhoto(String id) async {
    await _dioClient.delete('${ApiEndpoints.photos}/$id');
  }
}
