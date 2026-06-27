import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class PropertyViewingService {
  final DioClient _dioClient;
  PropertyViewingService(this._dioClient);

  Future<PropertyViewing> getPropertyViewingById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.propertyViewings}/$id');
    return PropertyViewing.fromJson(response.data['data']);
  }

  Future<List<PropertyViewing>> getPropertyViewings({
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
    final response = await _dioClient.get(ApiEndpoints.propertyViewings, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => PropertyViewing.fromJson(json)).toList();
  }

  Future<PropertyViewing> createPropertyViewing(PropertyViewing item) async {
    final response = await _dioClient.post(ApiEndpoints.propertyViewings, data: item.toJson());
    return PropertyViewing.fromJson(response.data['data']);
  }

  Future<PropertyViewing> updatePropertyViewing(String id, PropertyViewing item) async {
    final response = await _dioClient.patch('${ApiEndpoints.propertyViewings}/$id', data: item.toJson());
    return PropertyViewing.fromJson(response.data['data']);
  }

  Future<void> deletePropertyViewing(String id) async {
    await _dioClient.delete('${ApiEndpoints.propertyViewings}/$id');
  }
}
