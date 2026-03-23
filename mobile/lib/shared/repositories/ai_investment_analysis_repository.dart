import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/repository_exception.dart';

/// Repository for AiInvestmentAnalysis operations
/// Provides CRUD operations with proper error handling and type safety
class AiInvestmentAnalysisRepository {
  final DioClient _dioClient;

  AiInvestmentAnalysisRepository(this._dioClient);

  /// Get AiInvestmentAnalysis by ID
  /// Returns [AiInvestmentAnalysis] if found, throws [RepositoryException] otherwise
  Future<AiInvestmentAnalysis> getAiInvestmentAnalysisById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/ai_investment_analysis/$id');
      if (response.statusCode == 200) {
        return AiInvestmentAnalysis.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to fetch ai_investment_analysis',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.notFound,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all ai_investment_analysises with pagination and filtering
  /// Returns list of [AiInvestmentAnalysis] objects
  Future<List<AiInvestmentAnalysis>> getai_investment_analysises({
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
      
      final response = await _dioClient.get('/api/v1/ai_investment_analysis', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => AiInvestmentAnalysis.fromJson(item)).toList();
      } else {
        throw RepositoryException(
          message: 'Failed to fetch ai_investment_analysises',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new AiInvestmentAnalysis
  /// Returns created [AiInvestmentAnalysis] object
  Future<AiInvestmentAnalysis> createAiInvestmentAnalysis(AiInvestmentAnalysis aiInvestmentAnalysis) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/ai_investment_analysis',
        data: aiInvestmentAnalysis.toJson(),
      );
      return AiInvestmentAnalysis.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update AiInvestmentAnalysis
  Future<AiInvestmentAnalysis> updateAiInvestmentAnalysis(String id, AiInvestmentAnalysis aiInvestmentAnalysis) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/ai_investment_analysis/$id',
        data: aiInvestmentAnalysis.toJson(),
      );
      return AiInvestmentAnalysis.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete AiInvestmentAnalysis
  Future<void> deleteAiInvestmentAnalysis(String id) async {
    try {
      await _dioClient.delete('/api/v1/ai_investment_analysis/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    // Implement error handling logic here
    return Exception('API Error: ${e.message}');
  }
}
