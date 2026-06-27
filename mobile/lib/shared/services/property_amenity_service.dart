import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class PropertyAmenityService {
  final DioClient _dioClient;
  PropertyAmenityService(this._dioClient);

  Future<PropertyAmenity> getPropertyAmenityById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.propertyAmenities}/$id');
    return PropertyAmenity.fromJson(response.data['data']);
  }

  Future<List<PropertyAmenity>> getPropertyAmenities({
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
    final response = await _dioClient.get(ApiEndpoints.propertyAmenities, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => PropertyAmenity.fromJson(json)).toList();
  }

  Future<PropertyAmenity> createPropertyAmenity(PropertyAmenity item) async {
    final response = await _dioClient.post(ApiEndpoints.propertyAmenities, data: item.toJson());
    return PropertyAmenity.fromJson(response.data['data']);
  }

  Future<PropertyAmenity> updatePropertyAmenity(String id, PropertyAmenity item) async {
    final response = await _dioClient.patch('${ApiEndpoints.propertyAmenities}/$id', data: item.toJson());
    return PropertyAmenity.fromJson(response.data['data']);
  }

  Future<void> deletePropertyAmenity(String id) async {
    await _dioClient.delete('${ApiEndpoints.propertyAmenities}/$id');
  }
}
