import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class RolePermissionService {
  final DioClient _dioClient;

  RolePermissionService(this._dioClient);

  // Get RolePermission by ID
  Future<RolePermission> getRolePermissionById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/role_permission/$id');
      return RolePermission.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all role_permissions
  Future<List<RolePermission>> getRolePermissions({
    int page = 1,
    int limit = 20,
    Map<String, dynamic>? filters,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'page': page.toString(),
        'limit': limit.toString(),
      };

      if (filters != null) {
        queryParams.addAll(filters);
      }

      final response = await _dioClient.get('/api/v1/role_permission', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => RolePermission.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create RolePermission
  Future<RolePermission> createRolePermission(RolePermission rolePermission) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/role_permission',
        data: rolePermission.toJson(),
      );
      return RolePermission.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update RolePermission
  Future<RolePermission> updateRolePermission(String id, RolePermission rolePermission) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/role_permission/$id',
        data: rolePermission.toJson(),
      );
      return RolePermission.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete RolePermission
  Future<void> deleteRolePermission(String id) async {
    try {
      await _dioClient.delete('/api/v1/role_permission/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
