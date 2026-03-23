import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/repository_exception.dart';

/// Repository for AiLeadScoring operations
/// Provides CRUD operations with proper error handling and type safety
class AiLeadScoringRepository {
  final DioClient _dioClient;

  AiLeadScoringRepository(this._dioClient);

  /// Get AiLeadScoring by ID
  /// Returns [AiLeadScoring] if found, throws [RepositoryException] otherwise
  Future<AiLeadScoring> getAiLeadScoringById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/ai_lead_scoring/$id');
      if (response.statusCode == 200) {
        return AiLeadScoring.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to fetch ai_lead_scoring',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.notFound,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all ai_lead_scorings with pagination and filtering
  /// Returns list of [AiLeadScoring] objects
  Future<List<AiLeadScoring>> getai_lead_scorings({
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
      
      final response = await _dioClient.get('/api/v1/ai_lead_scoring', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => AiLeadScoring.fromJson(item)).toList();
      } else {
        throw RepositoryException(
          message: 'Failed to fetch ai_lead_scorings',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new AiLeadScoring
  /// Returns created [AiLeadScoring] object
  Future<AiLeadScoring> createAiLeadScoring(AiLeadScoring aiLeadScoring) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/ai_lead_scoring',
        data: aiLeadScoring.toJson(),
      );
      return AiLeadScoring.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update AiLeadScoring
  Future<AiLeadScoring> updateAiLeadScoring(String id, AiLeadScoring aiLeadScoring) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/ai_lead_scoring/$id',
        data: aiLeadScoring.toJson(),
      );
      return AiLeadScoring.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete AiLeadScoring
  Future<void> deleteAiLeadScoring(String id) async {
    try {
      await _dioClient.delete('/api/v1/ai_lead_scoring/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    // Implement error handling logic here
    return Exception('API Error: ${e.message}');
  }
}
