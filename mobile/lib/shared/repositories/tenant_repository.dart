import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/repository_exception.dart';

/// Repository for Tenant operations
/// Provides CRUD operations with proper error handling and type safety
class TenantRepository {
  final DioClient _dioClient;

  TenantRepository(this._dioClient);

  /// Get Tenant by ID
  /// Returns [Tenant] if found, throws [RepositoryException] otherwise
  Future<Tenant> getTenantById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/tenant/$id');
      if (response.statusCode == 200) {
        return Tenant.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to fetch tenant',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.notFound,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all tenants with pagination and filtering
  /// Returns list of [Tenant] objects
  Future<List<Tenant>> gettenants({
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
      
      final response = await _dioClient.get('/api/v1/tenant', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => Tenant.fromJson(item)).toList();
      } else {
        throw RepositoryException(
          message: 'Failed to fetch tenants',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new Tenant
  /// Returns created [Tenant] object
  Future<Tenant> createTenant(Tenant tenant) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/tenant',
        data: tenant.toJson(),
      );
      return Tenant.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update Tenant
  Future<Tenant> updateTenant(String id, Tenant tenant) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/tenant/$id',
        data: tenant.toJson(),
      );
      return Tenant.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete Tenant
  Future<void> deleteTenant(String id) async {
    try {
      await _dioClient.delete('/api/v1/tenant/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    // Implement error handling logic here
    return Exception('API Error: ${e.message}');
  }
}
