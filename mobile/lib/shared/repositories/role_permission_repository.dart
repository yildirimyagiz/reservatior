import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/repository_exception.dart';

/// Repository for RolePermission operations
/// Provides CRUD operations with proper error handling and type safety
class RolePermissionRepository {
  final DioClient _dioClient;

  RolePermissionRepository(this._dioClient);

  /// Get RolePermission by ID
  /// Returns [RolePermission] if found, throws [RepositoryException] otherwise
  Future<RolePermission> getRolePermissionById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/role_permission/$id');
      if (response.statusCode == 200) {
        return RolePermission.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to fetch role_permission',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.notFound,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all role_permissions with pagination and filtering
  /// Returns list of [RolePermission] objects
  Future<List<RolePermission>> getrole_permissions({
    int page = 1,
    int limit = 20,
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'page': page,
        'limit': limit,
        if (sortBy != null) 'sort_by': sortBy,
        if (sortOrder != null) 'sort_order': sortOrder,
        ...?filters,
      };
      
      final response = await _dioClient.get('/api/v1/role_permission', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => RolePermission.fromJson(item)).toList();
      } else {
        throw RepositoryException(
          message: 'Failed to fetch role_permissions',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new RolePermission
  /// Returns created [RolePermission] object
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
    // Implement error handling logic here
    return Exception('API Error: ${e.message}');
  }
}
