import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/repository_exception.dart';

/// Repository for AiPropertyValuation operations
/// Provides CRUD operations with proper error handling and type safety
class AiPropertyValuationRepository {
  final DioClient _dioClient;

  AiPropertyValuationRepository(this._dioClient);

  /// Get AiPropertyValuation by ID
  /// Returns [AiPropertyValuation] if found, throws [RepositoryException] otherwise
  Future<AiPropertyValuation> getAiPropertyValuationById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/ai_property_valuation/$id');
      if (response.statusCode == 200) {
        return AiPropertyValuation.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to fetch ai_property_valuation',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.notFound,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all ai_property_valuations with pagination and filtering
  /// Returns list of [AiPropertyValuation] objects
  Future<List<AiPropertyValuation>> getai_property_valuations({
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
      
      final response = await _dioClient.get('/api/v1/ai_property_valuation', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => AiPropertyValuation.fromJson(item)).toList();
      } else {
        throw RepositoryException(
          message: 'Failed to fetch ai_property_valuations',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new AiPropertyValuation
  /// Returns created [AiPropertyValuation] object
  Future<AiPropertyValuation> createAiPropertyValuation(AiPropertyValuation aiPropertyValuation) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/ai_property_valuation',
        data: aiPropertyValuation.toJson(),
      );
      return AiPropertyValuation.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update AiPropertyValuation
  Future<AiPropertyValuation> updateAiPropertyValuation(String id, AiPropertyValuation aiPropertyValuation) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/ai_property_valuation/$id',
        data: aiPropertyValuation.toJson(),
      );
      return AiPropertyValuation.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete AiPropertyValuation
  Future<void> deleteAiPropertyValuation(String id) async {
    try {
      await _dioClient.delete('/api/v1/ai_property_valuation/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    // Implement error handling logic here
    return Exception('API Error: ${e.message}');
  }
}
