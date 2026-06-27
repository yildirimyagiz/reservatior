import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class PropertyDisclosureService {
  final DioClient _dioClient;
  PropertyDisclosureService(this._dioClient);

  Future<PropertyDisclosure> getPropertyDisclosureById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.propertyDisclosures}/$id');
    return PropertyDisclosure.fromJson(response.data['data']);
  }

  Future<List<PropertyDisclosure>> getPropertyDisclosures({
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
    final response = await _dioClient.get(ApiEndpoints.propertyDisclosures, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => PropertyDisclosure.fromJson(json)).toList();
  }

  Future<PropertyDisclosure> createPropertyDisclosure(PropertyDisclosure item) async {
    final response = await _dioClient.post(ApiEndpoints.propertyDisclosures, data: item.toJson());
    return PropertyDisclosure.fromJson(response.data['data']);
  }

  Future<PropertyDisclosure> updatePropertyDisclosure(String id, PropertyDisclosure item) async {
    final response = await _dioClient.patch('${ApiEndpoints.propertyDisclosures}/$id', data: item.toJson());
    return PropertyDisclosure.fromJson(response.data['data']);
  }

  Future<void> deletePropertyDisclosure(String id) async {
    await _dioClient.delete('${ApiEndpoints.propertyDisclosures}/$id');
  }
}
