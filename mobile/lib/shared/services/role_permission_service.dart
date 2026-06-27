import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class RolePermissionService {
  final DioClient _dioClient;
  RolePermissionService(this._dioClient);

  Future<RolePermission> getRolePermissionById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.rolePermissions}/$id');
    return RolePermission.fromJson(response.data['data']);
  }

  Future<List<RolePermission>> getRolePermissions({
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
    final response = await _dioClient.get(ApiEndpoints.rolePermissions, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => RolePermission.fromJson(json)).toList();
  }

  Future<RolePermission> createRolePermission(RolePermission item) async {
    final response = await _dioClient.post(ApiEndpoints.rolePermissions, data: item.toJson());
    return RolePermission.fromJson(response.data['data']);
  }

  Future<RolePermission> updateRolePermission(String id, RolePermission item) async {
    final response = await _dioClient.patch('${ApiEndpoints.rolePermissions}/$id', data: item.toJson());
    return RolePermission.fromJson(response.data['data']);
  }

  Future<void> deleteRolePermission(String id) async {
    await _dioClient.delete('${ApiEndpoints.rolePermissions}/$id');
  }
}
