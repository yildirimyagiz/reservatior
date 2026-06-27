import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class PropertyInventoryService {
  final DioClient _dioClient;
  PropertyInventoryService(this._dioClient);

  Future<PropertyInventory> getPropertyInventoryById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.propertyInventories}/$id');
    return PropertyInventory.fromJson(response.data['data']);
  }

  Future<List<PropertyInventory>> getPropertyInventories({
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
    final response = await _dioClient.get(ApiEndpoints.propertyInventories, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => PropertyInventory.fromJson(json)).toList();
  }

  Future<PropertyInventory> createPropertyInventory(PropertyInventory item) async {
    final response = await _dioClient.post(ApiEndpoints.propertyInventories, data: item.toJson());
    return PropertyInventory.fromJson(response.data['data']);
  }

  Future<PropertyInventory> updatePropertyInventory(String id, PropertyInventory item) async {
    final response = await _dioClient.patch('${ApiEndpoints.propertyInventories}/$id', data: item.toJson());
    return PropertyInventory.fromJson(response.data['data']);
  }

  Future<void> deletePropertyInventory(String id) async {
    await _dioClient.delete('${ApiEndpoints.propertyInventories}/$id');
  }
}
