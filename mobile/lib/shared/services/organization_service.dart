import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class OrganizationService {
  final DioClient _dioClient;
  OrganizationService(this._dioClient);

  Future<Organization> getOrganizationById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.organizations}/$id');
    return Organization.fromJson(response.data['data']);
  }

  Future<List<Organization>> getOrganizations({
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
    final response = await _dioClient.get(ApiEndpoints.organizations, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => Organization.fromJson(json)).toList();
  }

  Future<Organization> createOrganization(Organization item) async {
    final response = await _dioClient.post(ApiEndpoints.organizations, data: item.toJson());
    return Organization.fromJson(response.data['data']);
  }

  Future<Organization> updateOrganization(String id, Organization item) async {
    final response = await _dioClient.patch('${ApiEndpoints.organizations}/$id', data: item.toJson());
    return Organization.fromJson(response.data['data']);
  }

  Future<void> deleteOrganization(String id) async {
    await _dioClient.delete('${ApiEndpoints.organizations}/$id');
  }
}
