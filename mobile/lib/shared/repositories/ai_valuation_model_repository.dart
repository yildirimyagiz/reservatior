import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/repository_exception.dart';

/// Repository for AiValuationModel operations
/// Provides CRUD operations with proper error handling and type safety
class AiValuationModelRepository {
  final DioClient _dioClient;

  AiValuationModelRepository(this._dioClient);

  /// Get AiValuationModel by ID
  /// Returns [AiValuationModel] if found, throws [RepositoryException] otherwise
  Future<AiValuationModel> getAiValuationModelById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/ai_valuation_model/$id');
      if (response.statusCode == 200) {
        return AiValuationModel.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to fetch ai_valuation_model',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.notFound,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all ai_valuation_models with pagination and filtering
  /// Returns list of [AiValuationModel] objects
  Future<List<AiValuationModel>> getai_valuation_models({
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
      
      final response = await _dioClient.get('/api/v1/ai_valuation_model', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => AiValuationModel.fromJson(item)).toList();
      } else {
        throw RepositoryException(
          message: 'Failed to fetch ai_valuation_models',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new AiValuationModel
  /// Returns created [AiValuationModel] object
  Future<AiValuationModel> createAiValuationModel(AiValuationModel aiValuationModel) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/ai_valuation_model',
        data: aiValuationModel.toJson(),
      );
      return AiValuationModel.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update AiValuationModel
  Future<AiValuationModel> updateAiValuationModel(String id, AiValuationModel aiValuationModel) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/ai_valuation_model/$id',
        data: aiValuationModel.toJson(),
      );
      return AiValuationModel.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete AiValuationModel
  Future<void> deleteAiValuationModel(String id) async {
    try {
      await _dioClient.delete('/api/v1/ai_valuation_model/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    // Implement error handling logic here
    return Exception('API Error: ${e.message}');
  }
}
