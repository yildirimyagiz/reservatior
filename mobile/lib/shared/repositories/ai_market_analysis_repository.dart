import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/repository_exception.dart';

/// Repository for AiMarketAnalysis operations
/// Provides CRUD operations with proper error handling and type safety
class AiMarketAnalysisRepository {
  final DioClient _dioClient;

  AiMarketAnalysisRepository(this._dioClient);

  /// Get AiMarketAnalysis by ID
  /// Returns [AiMarketAnalysis] if found, throws [RepositoryException] otherwise
  Future<AiMarketAnalysis> getAiMarketAnalysisById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/ai_market_analysis/$id');
      if (response.statusCode == 200) {
        return AiMarketAnalysis.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to fetch ai_market_analysis',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.notFound,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all ai_market_analysises with pagination and filtering
  /// Returns list of [AiMarketAnalysis] objects
  Future<List<AiMarketAnalysis>> getai_market_analysises({
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
      
      final response = await _dioClient.get('/api/v1/ai_market_analysis', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => AiMarketAnalysis.fromJson(item)).toList();
      } else {
        throw RepositoryException(
          message: 'Failed to fetch ai_market_analysises',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new AiMarketAnalysis
  /// Returns created [AiMarketAnalysis] object
  Future<AiMarketAnalysis> createAiMarketAnalysis(AiMarketAnalysis aiMarketAnalysis) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/ai_market_analysis',
        data: aiMarketAnalysis.toJson(),
      );
      return AiMarketAnalysis.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update AiMarketAnalysis
  Future<AiMarketAnalysis> updateAiMarketAnalysis(String id, AiMarketAnalysis aiMarketAnalysis) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/ai_market_analysis/$id',
        data: aiMarketAnalysis.toJson(),
      );
      return AiMarketAnalysis.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete AiMarketAnalysis
  Future<void> deleteAiMarketAnalysis(String id) async {
    try {
      await _dioClient.delete('/api/v1/ai_market_analysis/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    // Implement error handling logic here
    return Exception('API Error: ${e.message}');
  }
}
