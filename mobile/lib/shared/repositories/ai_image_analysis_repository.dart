import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/repository_exception.dart';

/// Repository for AiImageAnalysis operations
/// Provides CRUD operations with proper error handling and type safety
class AiImageAnalysisRepository {
  final DioClient _dioClient;

  AiImageAnalysisRepository(this._dioClient);

  /// Get AiImageAnalysis by ID
  /// Returns [AiImageAnalysis] if found, throws [RepositoryException] otherwise
  Future<AiImageAnalysis> getAiImageAnalysisById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/ai_image_analysis/$id');
      if (response.statusCode == 200) {
        return AiImageAnalysis.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to fetch ai_image_analysis',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.notFound,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all ai_image_analysises with pagination and filtering
  /// Returns list of [AiImageAnalysis] objects
  Future<List<AiImageAnalysis>> getai_image_analysises({
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
      
      final response = await _dioClient.get('/api/v1/ai_image_analysis', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => AiImageAnalysis.fromJson(item)).toList();
      } else {
        throw RepositoryException(
          message: 'Failed to fetch ai_image_analysises',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new AiImageAnalysis
  /// Returns created [AiImageAnalysis] object
  Future<AiImageAnalysis> createAiImageAnalysis(AiImageAnalysis aiImageAnalysis) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/ai_image_analysis',
        data: aiImageAnalysis.toJson(),
      );
      return AiImageAnalysis.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update AiImageAnalysis
  Future<AiImageAnalysis> updateAiImageAnalysis(String id, AiImageAnalysis aiImageAnalysis) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/ai_image_analysis/$id',
        data: aiImageAnalysis.toJson(),
      );
      return AiImageAnalysis.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete AiImageAnalysis
  Future<void> deleteAiImageAnalysis(String id) async {
    try {
      await _dioClient.delete('/api/v1/ai_image_analysis/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    // Implement error handling logic here
    return Exception('API Error: ${e.message}');
  }
}
