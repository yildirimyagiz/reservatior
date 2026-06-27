import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class PropertyService {
  final DioClient _dioClient;
  PropertyService(this._dioClient);

  Future<Property> getPropertyById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.properties}/$id');
    return Property.fromJson(response.data['data']);
  }

  Future<List<Property>> getProperties({
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
      if (filters != null) ...filters,
      'include': 'listings.pricingRules', // Include pricingRules with listings
    };
    final response = await _dioClient.get(ApiEndpoints.properties, queryParameters: queryParams);
    
    print('🏠 Property Response: ${response.data}');
    
    final data = response.data['data'] as List;
    print('🏠 Property Parsed ${data.length} items');
    return data.map((json) => Property.fromJson(json)).toList();
  }

  Future<Property> createProperty(Property item) async {
    final response = await _dioClient.post(ApiEndpoints.properties, data: item.toJson());
    return Property.fromJson(response.data['data']);
  }

  Future<Property> updateProperty(String id, Property item) async {
    final response = await _dioClient.patch('${ApiEndpoints.properties}/$id', data: item.toJson());
    return Property.fromJson(response.data['data']);
  }

  Future<void> deleteProperty(String id) async {
    await _dioClient.delete('${ApiEndpoints.properties}/$id');
  }
}
