import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/repository_exception.dart';

/// Repository for AiSentimentAnalysis operations
/// Provides CRUD operations with proper error handling and type safety
class AiSentimentAnalysisRepository {
  final DioClient _dioClient;

  AiSentimentAnalysisRepository(this._dioClient);

  /// Get AiSentimentAnalysis by ID
  /// Returns [AiSentimentAnalysis] if found, throws [RepositoryException] otherwise
  Future<AiSentimentAnalysis> getAiSentimentAnalysisById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/ai_sentiment_analysis/$id');
      if (response.statusCode == 200) {
        return AiSentimentAnalysis.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to fetch ai_sentiment_analysis',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.notFound,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all ai_sentiment_analysises with pagination and filtering
  /// Returns list of [AiSentimentAnalysis] objects
  Future<List<AiSentimentAnalysis>> getai_sentiment_analysises({
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
      
      final response = await _dioClient.get('/api/v1/ai_sentiment_analysis', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => AiSentimentAnalysis.fromJson(item)).toList();
      } else {
        throw RepositoryException(
          message: 'Failed to fetch ai_sentiment_analysises',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new AiSentimentAnalysis
  /// Returns created [AiSentimentAnalysis] object
  Future<AiSentimentAnalysis> createAiSentimentAnalysis(AiSentimentAnalysis aiSentimentAnalysis) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/ai_sentiment_analysis',
        data: aiSentimentAnalysis.toJson(),
      );
      return AiSentimentAnalysis.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update AiSentimentAnalysis
  Future<AiSentimentAnalysis> updateAiSentimentAnalysis(String id, AiSentimentAnalysis aiSentimentAnalysis) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/ai_sentiment_analysis/$id',
        data: aiSentimentAnalysis.toJson(),
      );
      return AiSentimentAnalysis.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete AiSentimentAnalysis
  Future<void> deleteAiSentimentAnalysis(String id) async {
    try {
      await _dioClient.delete('/api/v1/ai_sentiment_analysis/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    // Implement error handling logic here
    return Exception('API Error: ${e.message}');
  }
}
