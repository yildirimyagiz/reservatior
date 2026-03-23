import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/repository_exception.dart';

/// Repository for ApiToken operations
/// Provides CRUD operations with proper error handling and type safety
class ApiTokenRepository {
  final DioClient _dioClient;

  ApiTokenRepository(this._dioClient);

  /// Get ApiToken by ID
  /// Returns [ApiToken] if found, throws [RepositoryException] otherwise
  Future<ApiToken> getApiTokenById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/api_token/$id');
      if (response.statusCode == 200) {
        return ApiToken.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to fetch api_token',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.notFound,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all api_tokens with pagination and filtering
  /// Returns list of [ApiToken] objects
  Future<List<ApiToken>> getapi_tokens({
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
      
      final response = await _dioClient.get('/api/v1/api_token', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => ApiToken.fromJson(item)).toList();
      } else {
        throw RepositoryException(
          message: 'Failed to fetch api_tokens',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new ApiToken
  /// Returns created [ApiToken] object
  Future<ApiToken> createApiToken(ApiToken apiToken) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/api_token',
        data: apiToken.toJson(),
      );
      return ApiToken.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update ApiToken
  Future<ApiToken> updateApiToken(String id, ApiToken apiToken) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/api_token/$id',
        data: apiToken.toJson(),
      );
      return ApiToken.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete ApiToken
  Future<void> deleteApiToken(String id) async {
    try {
      await _dioClient.delete('/api/v1/api_token/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    // Implement error handling logic here
    return Exception('API Error: ${e.message}');
  }
}
