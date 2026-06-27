import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class PermissionService {
  final DioClient _dioClient;
  PermissionService(this._dioClient);

  Future<Permission> getPermissionById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.permissions}/$id');
    return Permission.fromJson(response.data['data']);
  }

  Future<List<Permission>> getPermissions({
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
    final response = await _dioClient.get(ApiEndpoints.permissions, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => Permission.fromJson(json)).toList();
  }

  Future<Permission> createPermission(Permission item) async {
    final response = await _dioClient.post(ApiEndpoints.permissions, data: item.toJson());
    return Permission.fromJson(response.data['data']);
  }

  Future<Permission> updatePermission(String id, Permission item) async {
    final response = await _dioClient.patch('${ApiEndpoints.permissions}/$id', data: item.toJson());
    return Permission.fromJson(response.data['data']);
  }

  Future<void> deletePermission(String id) async {
    await _dioClient.delete('${ApiEndpoints.permissions}/$id');
  }
}
