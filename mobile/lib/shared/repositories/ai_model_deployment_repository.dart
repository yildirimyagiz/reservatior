import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/repository_exception.dart';

/// Repository for AiModelDeployment operations
/// Provides CRUD operations with proper error handling and type safety
class AiModelDeploymentRepository {
  final DioClient _dioClient;

  AiModelDeploymentRepository(this._dioClient);

  /// Get AiModelDeployment by ID
  /// Returns [AiModelDeployment] if found, throws [RepositoryException] otherwise
  Future<AiModelDeployment> getAiModelDeploymentById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/ai_model_deployment/$id');
      if (response.statusCode == 200) {
        return AiModelDeployment.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to fetch ai_model_deployment',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.notFound,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all ai_model_deployments with pagination and filtering
  /// Returns list of [AiModelDeployment] objects
  Future<List<AiModelDeployment>> getai_model_deployments({
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
      
      final response = await _dioClient.get('/api/v1/ai_model_deployment', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => AiModelDeployment.fromJson(item)).toList();
      } else {
        throw RepositoryException(
          message: 'Failed to fetch ai_model_deployments',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new AiModelDeployment
  /// Returns created [AiModelDeployment] object
  Future<AiModelDeployment> createAiModelDeployment(AiModelDeployment aiModelDeployment) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/ai_model_deployment',
        data: aiModelDeployment.toJson(),
      );
      return AiModelDeployment.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update AiModelDeployment
  Future<AiModelDeployment> updateAiModelDeployment(String id, AiModelDeployment aiModelDeployment) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/ai_model_deployment/$id',
        data: aiModelDeployment.toJson(),
      );
      return AiModelDeployment.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete AiModelDeployment
  Future<void> deleteAiModelDeployment(String id) async {
    try {
      await _dioClient.delete('/api/v1/ai_model_deployment/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    // Implement error handling logic here
    return Exception('API Error: ${e.message}');
  }
}
