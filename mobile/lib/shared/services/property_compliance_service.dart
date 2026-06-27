import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class PropertyComplianceService {
  final DioClient _dioClient;
  PropertyComplianceService(this._dioClient);

  Future<PropertyCompliance> getPropertyComplianceById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.propertyCompliances}/$id');
    return PropertyCompliance.fromJson(response.data['data']);
  }

  Future<List<PropertyCompliance>> getPropertyCompliances({
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
    final response = await _dioClient.get(ApiEndpoints.propertyCompliances, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => PropertyCompliance.fromJson(json)).toList();
  }

  Future<PropertyCompliance> createPropertyCompliance(PropertyCompliance item) async {
    final response = await _dioClient.post(ApiEndpoints.propertyCompliances, data: item.toJson());
    return PropertyCompliance.fromJson(response.data['data']);
  }

  Future<PropertyCompliance> updatePropertyCompliance(String id, PropertyCompliance item) async {
    final response = await _dioClient.patch('${ApiEndpoints.propertyCompliances}/$id', data: item.toJson());
    return PropertyCompliance.fromJson(response.data['data']);
  }

  Future<void> deletePropertyCompliance(String id) async {
    await _dioClient.delete('${ApiEndpoints.propertyCompliances}/$id');
  }
}
