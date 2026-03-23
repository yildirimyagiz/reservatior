import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/repository_exception.dart';

/// Repository for AiRecommendation operations
/// Provides CRUD operations with proper error handling and type safety
class AiRecommendationRepository {
  final DioClient _dioClient;

  AiRecommendationRepository(this._dioClient);

  /// Get AiRecommendation by ID
  /// Returns [AiRecommendation] if found, throws [RepositoryException] otherwise
  Future<AiRecommendation> getAiRecommendationById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/ai_recommendation/$id');
      if (response.statusCode == 200) {
        return AiRecommendation.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to fetch ai_recommendation',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.notFound,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all ai_recommendations with pagination and filtering
  /// Returns list of [AiRecommendation] objects
  Future<List<AiRecommendation>> getai_recommendations({
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
      
      final response = await _dioClient.get('/api/v1/ai_recommendation', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => AiRecommendation.fromJson(item)).toList();
      } else {
        throw RepositoryException(
          message: 'Failed to fetch ai_recommendations',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new AiRecommendation
  /// Returns created [AiRecommendation] object
  Future<AiRecommendation> createAiRecommendation(AiRecommendation aiRecommendation) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/ai_recommendation',
        data: aiRecommendation.toJson(),
      );
      return AiRecommendation.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update AiRecommendation
  Future<AiRecommendation> updateAiRecommendation(String id, AiRecommendation aiRecommendation) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/ai_recommendation/$id',
        data: aiRecommendation.toJson(),
      );
      return AiRecommendation.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete AiRecommendation
  Future<void> deleteAiRecommendation(String id) async {
    try {
      await _dioClient.delete('/api/v1/ai_recommendation/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    // Implement error handling logic here
    return Exception('API Error: ${e.message}');
  }
}
