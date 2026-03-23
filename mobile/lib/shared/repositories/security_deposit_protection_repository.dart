import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/repository_exception.dart';

/// Repository for SecurityDepositProtection operations
/// Provides CRUD operations with proper error handling and type safety
class SecurityDepositProtectionRepository {
  final DioClient _dioClient;

  SecurityDepositProtectionRepository(this._dioClient);

  /// Get SecurityDepositProtection by ID
  /// Returns [SecurityDepositProtection] if found, throws [RepositoryException] otherwise
  Future<SecurityDepositProtection> getSecurityDepositProtectionById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/security_deposit_protection/$id');
      if (response.statusCode == 200) {
        return SecurityDepositProtection.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to fetch security_deposit_protection',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.notFound,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all security_deposit_protections with pagination and filtering
  /// Returns list of [SecurityDepositProtection] objects
  Future<List<SecurityDepositProtection>> getsecurity_deposit_protections({
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
      
      final response = await _dioClient.get('/api/v1/security_deposit_protection', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => SecurityDepositProtection.fromJson(item)).toList();
      } else {
        throw RepositoryException(
          message: 'Failed to fetch security_deposit_protections',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new SecurityDepositProtection
  /// Returns created [SecurityDepositProtection] object
  Future<SecurityDepositProtection> createSecurityDepositProtection(SecurityDepositProtection securityDepositProtection) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/security_deposit_protection',
        data: securityDepositProtection.toJson(),
      );
      return SecurityDepositProtection.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update SecurityDepositProtection
  Future<SecurityDepositProtection> updateSecurityDepositProtection(String id, SecurityDepositProtection securityDepositProtection) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/security_deposit_protection/$id',
        data: securityDepositProtection.toJson(),
      );
      return SecurityDepositProtection.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete SecurityDepositProtection
  Future<void> deleteSecurityDepositProtection(String id) async {
    try {
      await _dioClient.delete('/api/v1/security_deposit_protection/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    // Implement error handling logic here
    return Exception('API Error: ${e.message}');
  }
}
