import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/repository_exception.dart';

/// Repository for Role operations
/// Provides CRUD operations with proper error handling and type safety
class RoleRepository {
  final DioClient _dioClient;

  RoleRepository(this._dioClient);

  /// Get Role by ID
  /// Returns [Role] if found, throws [RepositoryException] otherwise
  Future<Role> getRoleById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/role/$id');
      if (response.statusCode == 200) {
        return Role.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to fetch role',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.notFound,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all roles with pagination and filtering
  /// Returns list of [Role] objects
  Future<List<Role>> getroles({
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
      
      final response = await _dioClient.get('/api/v1/role', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => Role.fromJson(item)).toList();
      } else {
        throw RepositoryException(
          message: 'Failed to fetch roles',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new Role
  /// Returns created [Role] object
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
    // Implement error handling logic here
    return Exception('API Error: ${e.message}');
  }
}
