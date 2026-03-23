import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/repository_exception.dart';

/// Repository for AiPrediction operations
/// Provides CRUD operations with proper error handling and type safety
class AiPredictionRepository {
  final DioClient _dioClient;

  AiPredictionRepository(this._dioClient);

  /// Get AiPrediction by ID
  /// Returns [AiPrediction] if found, throws [RepositoryException] otherwise
  Future<AiPrediction> getAiPredictionById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/ai_prediction/$id');
      if (response.statusCode == 200) {
        return AiPrediction.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to fetch ai_prediction',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.notFound,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all ai_predictions with pagination and filtering
  /// Returns list of [AiPrediction] objects
  Future<List<AiPrediction>> getai_predictions({
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
      
      final response = await _dioClient.get('/api/v1/ai_prediction', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => AiPrediction.fromJson(item)).toList();
      } else {
        throw RepositoryException(
          message: 'Failed to fetch ai_predictions',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new AiPrediction
  /// Returns created [AiPrediction] object
  Future<AiPrediction> createAiPrediction(AiPrediction aiPrediction) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/ai_prediction',
        data: aiPrediction.toJson(),
      );
      return AiPrediction.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update AiPrediction
  Future<AiPrediction> updateAiPrediction(String id, AiPrediction aiPrediction) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/ai_prediction/$id',
        data: aiPrediction.toJson(),
      );
      return AiPrediction.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete AiPrediction
  Future<void> deleteAiPrediction(String id) async {
    try {
      await _dioClient.delete('/api/v1/ai_prediction/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    // Implement error handling logic here
    return Exception('API Error: ${e.message}');
  }
}
