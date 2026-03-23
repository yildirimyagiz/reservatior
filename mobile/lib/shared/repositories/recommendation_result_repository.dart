import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/repository_exception.dart';

/// Repository for RecommendationResult operations
/// Provides CRUD operations with proper error handling and type safety
class RecommendationResultRepository {
  final DioClient _dioClient;

  RecommendationResultRepository(this._dioClient);

  /// Get RecommendationResult by ID
  /// Returns [RecommendationResult] if found, throws [RepositoryException] otherwise
  Future<RecommendationResult> getRecommendationResultById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/recommendation_result/$id');
      if (response.statusCode == 200) {
        return RecommendationResult.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to fetch recommendation_result',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.notFound,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all recommendation_results with pagination and filtering
  /// Returns list of [RecommendationResult] objects
  Future<List<RecommendationResult>> getrecommendation_results({
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
      
      final response = await _dioClient.get('/api/v1/recommendation_result', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => RecommendationResult.fromJson(item)).toList();
      } else {
        throw RepositoryException(
          message: 'Failed to fetch recommendation_results',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new RecommendationResult
  /// Returns created [RecommendationResult] object
  Future<RecommendationResult> createRecommendationResult(RecommendationResult recommendationResult) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/recommendation_result',
        data: recommendationResult.toJson(),
      );
      return RecommendationResult.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update RecommendationResult
  Future<RecommendationResult> updateRecommendationResult(String id, RecommendationResult recommendationResult) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/recommendation_result/$id',
        data: recommendationResult.toJson(),
      );
      return RecommendationResult.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete RecommendationResult
  Future<void> deleteRecommendationResult(String id) async {
    try {
      await _dioClient.delete('/api/v1/recommendation_result/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    // Implement error handling logic here
    return Exception('API Error: ${e.message}');
  }
}
