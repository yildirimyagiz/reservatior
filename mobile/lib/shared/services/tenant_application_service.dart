import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class TenantApplicationService {
  final DioClient _dioClient;
  TenantApplicationService(this._dioClient);

  Future<TenantApplication> getTenantApplicationById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.tenantApplications}/$id');
    return TenantApplication.fromJson(response.data['data']);
  }

  Future<List<TenantApplication>> getTenantApplications({
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
    final response = await _dioClient.get(ApiEndpoints.tenantApplications, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => TenantApplication.fromJson(json)).toList();
  }

  Future<TenantApplication> createTenantApplication(TenantApplication item) async {
    final response = await _dioClient.post(ApiEndpoints.tenantApplications, data: item.toJson());
    return TenantApplication.fromJson(response.data['data']);
  }

  Future<TenantApplication> updateTenantApplication(String id, TenantApplication item) async {
    final response = await _dioClient.patch('${ApiEndpoints.tenantApplications}/$id', data: item.toJson());
    return TenantApplication.fromJson(response.data['data']);
  }

  Future<void> deleteTenantApplication(String id) async {
    await _dioClient.delete('${ApiEndpoints.tenantApplications}/$id');
  }
}
