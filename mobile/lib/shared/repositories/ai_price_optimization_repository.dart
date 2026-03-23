import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/repository_exception.dart';

/// Repository for AiPriceOptimization operations
/// Provides CRUD operations with proper error handling and type safety
class AiPriceOptimizationRepository {
  final DioClient _dioClient;

  AiPriceOptimizationRepository(this._dioClient);

  /// Get AiPriceOptimization by ID
  /// Returns [AiPriceOptimization] if found, throws [RepositoryException] otherwise
  Future<AiPriceOptimization> getAiPriceOptimizationById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/ai_price_optimization/$id');
      if (response.statusCode == 200) {
        return AiPriceOptimization.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to fetch ai_price_optimization',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.notFound,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all ai_price_optimizations with pagination and filtering
  /// Returns list of [AiPriceOptimization] objects
  Future<List<AiPriceOptimization>> getai_price_optimizations({
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
      
      final response = await _dioClient.get('/api/v1/ai_price_optimization', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => AiPriceOptimization.fromJson(item)).toList();
      } else {
        throw RepositoryException(
          message: 'Failed to fetch ai_price_optimizations',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new AiPriceOptimization
  /// Returns created [AiPriceOptimization] object
  Future<AiPriceOptimization> createAiPriceOptimization(AiPriceOptimization aiPriceOptimization) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/ai_price_optimization',
        data: aiPriceOptimization.toJson(),
      );
      return AiPriceOptimization.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update AiPriceOptimization
  Future<AiPriceOptimization> updateAiPriceOptimization(String id, AiPriceOptimization aiPriceOptimization) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/ai_price_optimization/$id',
        data: aiPriceOptimization.toJson(),
      );
      return AiPriceOptimization.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete AiPriceOptimization
  Future<void> deleteAiPriceOptimization(String id) async {
    try {
      await _dioClient.delete('/api/v1/ai_price_optimization/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    // Implement error handling logic here
    return Exception('API Error: ${e.message}');
  }
}
