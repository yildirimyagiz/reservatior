import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class TenantService {
  final DioClient _dioClient;
  TenantService(this._dioClient);

  Future<Tenant> getTenantById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.tenants}/$id');
    return Tenant.fromJson(response.data['data']);
  }

  Future<List<Tenant>> getTenants({
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
    final response = await _dioClient.get(ApiEndpoints.tenants, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => Tenant.fromJson(json)).toList();
  }

  Future<Tenant> createTenant(Tenant item) async {
    final response = await _dioClient.post(ApiEndpoints.tenants, data: item.toJson());
    return Tenant.fromJson(response.data['data']);
  }

  Future<Tenant> updateTenant(String id, Tenant item) async {
    final response = await _dioClient.patch('${ApiEndpoints.tenants}/$id', data: item.toJson());
    return Tenant.fromJson(response.data['data']);
  }

  Future<void> deleteTenant(String id) async {
    await _dioClient.delete('${ApiEndpoints.tenants}/$id');
  }
}
