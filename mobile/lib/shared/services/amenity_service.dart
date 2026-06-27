import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class AmenityService {
  final DioClient _dioClient;
  AmenityService(this._dioClient);

  Future<Amenity> getAmenityById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.amenities}/$id');
    return Amenity.fromJson(response.data['data']);
  }

  Future<List<Amenity>> getAmenities({
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
    final response = await _dioClient.get(ApiEndpoints.amenities, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => Amenity.fromJson(json)).toList();
  }

  Future<Amenity> createAmenity(Amenity item) async {
    final response = await _dioClient.post(ApiEndpoints.amenities, data: item.toJson());
    return Amenity.fromJson(response.data['data']);
  }

  Future<Amenity> updateAmenity(String id, Amenity item) async {
    final response = await _dioClient.patch('${ApiEndpoints.amenities}/$id', data: item.toJson());
    return Amenity.fromJson(response.data['data']);
  }

  Future<void> deleteAmenity(String id) async {
    await _dioClient.delete('${ApiEndpoints.amenities}/$id');
  }
}
