import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/repository_exception.dart';

/// Repository for KeyManagement operations
/// Provides CRUD operations with proper error handling and type safety
class KeyManagementRepository {
  final DioClient _dioClient;

  KeyManagementRepository(this._dioClient);

  /// Get KeyManagement by ID
  /// Returns [KeyManagement] if found, throws [RepositoryException] otherwise
  Future<KeyManagement> getKeyManagementById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/key_management/$id');
      if (response.statusCode == 200) {
        return KeyManagement.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to fetch key_management',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.notFound,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all key_managements with pagination and filtering
  /// Returns list of [KeyManagement] objects
  Future<List<KeyManagement>> getkey_managements({
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
      
      final response = await _dioClient.get('/api/v1/key_management', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => KeyManagement.fromJson(item)).toList();
      } else {
        throw RepositoryException(
          message: 'Failed to fetch key_managements',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new KeyManagement
  /// Returns created [KeyManagement] object
  Future<KeyManagement> createKeyManagement(KeyManagement keyManagement) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/key_management',
        data: keyManagement.toJson(),
      );
      return KeyManagement.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update KeyManagement
  Future<KeyManagement> updateKeyManagement(String id, KeyManagement keyManagement) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/key_management/$id',
        data: keyManagement.toJson(),
      );
      return KeyManagement.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete KeyManagement
  Future<void> deleteKeyManagement(String id) async {
    try {
      await _dioClient.delete('/api/v1/key_management/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    // Implement error handling logic here
    return Exception('API Error: ${e.message}');
  }
}
