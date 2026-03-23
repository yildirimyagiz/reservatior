import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/repository_exception.dart';

/// Repository for ApiIntegration operations
/// Provides CRUD operations with proper error handling and type safety
class ApiIntegrationRepository {
  final DioClient _dioClient;

  ApiIntegrationRepository(this._dioClient);

  /// Get ApiIntegration by ID
  /// Returns [ApiIntegration] if found, throws [RepositoryException] otherwise
  Future<ApiIntegration> getApiIntegrationById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/api_integration/$id');
      if (response.statusCode == 200) {
        return ApiIntegration.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to fetch api_integration',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.notFound,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all api_integrations with pagination and filtering
  /// Returns list of [ApiIntegration] objects
  Future<List<ApiIntegration>> getapi_integrations({
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
      
      final response = await _dioClient.get('/api/v1/api_integration', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => ApiIntegration.fromJson(item)).toList();
      } else {
        throw RepositoryException(
          message: 'Failed to fetch api_integrations',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new ApiIntegration
  /// Returns created [ApiIntegration] object
  Future<ApiIntegration> createApiIntegration(ApiIntegration apiIntegration) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/api_integration',
        data: apiIntegration.toJson(),
      );
      return ApiIntegration.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update ApiIntegration
  Future<ApiIntegration> updateApiIntegration(String id, ApiIntegration apiIntegration) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/api_integration/$id',
        data: apiIntegration.toJson(),
      );
      return ApiIntegration.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete ApiIntegration
  Future<void> deleteApiIntegration(String id) async {
    try {
      await _dioClient.delete('/api/v1/api_integration/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    // Implement error handling logic here
    return Exception('API Error: ${e.message}');
  }
}
