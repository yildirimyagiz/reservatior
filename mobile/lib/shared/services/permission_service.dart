import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class PermissionService {
  final DioClient _dioClient;

  PermissionService(this._dioClient);

  // Get Permission by ID
  Future<Permission> getPermissionById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/permission/$id');
      return Permission.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all permissions
  Future<List<Permission>> getPermissions({
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

      final response = await _dioClient.get('/api/v1/permission', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => Permission.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create Permission
  Future<Permission> createPermission(Permission permission) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/permission',
        data: permission.toJson(),
      );
      return Permission.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update Permission
  Future<Permission> updatePermission(String id, Permission permission) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/permission/$id',
        data: permission.toJson(),
      );
      return Permission.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete Permission
  Future<void> deletePermission(String id) async {
    try {
      await _dioClient.delete('/api/v1/permission/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
