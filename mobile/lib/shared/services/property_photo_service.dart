import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class PropertyPhotoService {
  final DioClient _dioClient;
  PropertyPhotoService(this._dioClient);

  Future<PropertyPhoto> getPropertyPhotoById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.propertyPhotos}/$id');
    return PropertyPhoto.fromJson(response.data['data']);
  }

  Future<List<PropertyPhoto>> getPropertyPhotos({
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
    final response = await _dioClient.get(ApiEndpoints.propertyPhotos, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => PropertyPhoto.fromJson(json)).toList();
  }

  Future<PropertyPhoto> createPropertyPhoto(PropertyPhoto item) async {
    final response = await _dioClient.post(ApiEndpoints.propertyPhotos, data: item.toJson());
    return PropertyPhoto.fromJson(response.data['data']);
  }

  Future<PropertyPhoto> updatePropertyPhoto(String id, PropertyPhoto item) async {
    final response = await _dioClient.patch('${ApiEndpoints.propertyPhotos}/$id', data: item.toJson());
    return PropertyPhoto.fromJson(response.data['data']);
  }

  Future<void> deletePropertyPhoto(String id) async {
    await _dioClient.delete('${ApiEndpoints.propertyPhotos}/$id');
  }
}
