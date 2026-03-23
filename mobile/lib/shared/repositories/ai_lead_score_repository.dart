import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/repository_exception.dart';

/// Repository for AiLeadScore operations
/// Provides CRUD operations with proper error handling and type safety
class AiLeadScoreRepository {
  final DioClient _dioClient;

  AiLeadScoreRepository(this._dioClient);

  /// Get AiLeadScore by ID
  /// Returns [AiLeadScore] if found, throws [RepositoryException] otherwise
  Future<AiLeadScore> getAiLeadScoreById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/ai_lead_score/$id');
      if (response.statusCode == 200) {
        return AiLeadScore.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to fetch ai_lead_score',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.notFound,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all ai_lead_scores with pagination and filtering
  /// Returns list of [AiLeadScore] objects
  Future<List<AiLeadScore>> getai_lead_scores({
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
      
      final response = await _dioClient.get('/api/v1/ai_lead_score', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => AiLeadScore.fromJson(item)).toList();
      } else {
        throw RepositoryException(
          message: 'Failed to fetch ai_lead_scores',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new AiLeadScore
  /// Returns created [AiLeadScore] object
  Future<AiLeadScore> createAiLeadScore(AiLeadScore aiLeadScore) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/ai_lead_score',
        data: aiLeadScore.toJson(),
      );
      return AiLeadScore.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update AiLeadScore
  Future<AiLeadScore> updateAiLeadScore(String id, AiLeadScore aiLeadScore) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/ai_lead_score/$id',
        data: aiLeadScore.toJson(),
      );
      return AiLeadScore.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete AiLeadScore
  Future<void> deleteAiLeadScore(String id) async {
    try {
      await _dioClient.delete('/api/v1/ai_lead_score/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    // Implement error handling logic here
    return Exception('API Error: ${e.message}');
  }
}
