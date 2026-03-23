import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/repository_exception.dart';

/// Repository for AiModel operations
/// Provides CRUD operations with proper error handling and type safety
class AiModelRepository {
  final DioClient _dioClient;

  AiModelRepository(this._dioClient);

  /// Get AiModel by ID
  /// Returns [AiModel] if found, throws [RepositoryException] otherwise
  Future<AiModel> getAiModelById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/ai_model/$id');
      if (response.statusCode == 200) {
        return AiModel.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to fetch ai_model',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.notFound,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all ai_models with pagination and filtering
  /// Returns list of [AiModel] objects
  Future<List<AiModel>> getai_models({
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
      
      final response = await _dioClient.get('/api/v1/ai_model', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => AiModel.fromJson(item)).toList();
      } else {
        throw RepositoryException(
          message: 'Failed to fetch ai_models',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new AiModel
  /// Returns created [AiModel] object
  Future<AiModel> createAiModel(AiModel aiModel) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/ai_model',
        data: aiModel.toJson(),
      );
      return AiModel.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update AiModel
  Future<AiModel> updateAiModel(String id, AiModel aiModel) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/ai_model/$id',
        data: aiModel.toJson(),
      );
      return AiModel.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete AiModel
  Future<void> deleteAiModel(String id) async {
    try {
      await _dioClient.delete('/api/v1/ai_model/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    // Implement error handling logic here
    return Exception('API Error: ${e.message}');
  }
}
