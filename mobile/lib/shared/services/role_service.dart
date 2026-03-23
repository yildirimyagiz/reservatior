import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class RoleService {
  final DioClient _dioClient;

  RoleService(this._dioClient);

  // Get Role by ID
  Future<Role> getRoleById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/role/$id');
      return Role.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all roles
  Future<List<Role>> getRoles({
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

      final response = await _dioClient.get('/api/v1/role', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => Role.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create Role
  Future<Role> createRole(Role role) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/role',
        data: role.toJson(),
      );
      return Role.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update Role
  Future<Role> updateRole(String id, Role role) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/role/$id',
        data: role.toJson(),
      );
      return Role.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete Role
  Future<void> deleteRole(String id) async {
    try {
      await _dioClient.delete('/api/v1/role/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
