import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/repository_exception.dart';

/// Repository for AiPropertyDescription operations
/// Provides CRUD operations with proper error handling and type safety
class AiPropertyDescriptionRepository {
  final DioClient _dioClient;

  AiPropertyDescriptionRepository(this._dioClient);

  /// Get AiPropertyDescription by ID
  /// Returns [AiPropertyDescription] if found, throws [RepositoryException] otherwise
  Future<AiPropertyDescription> getAiPropertyDescriptionById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/ai_property_description/$id');
      if (response.statusCode == 200) {
        return AiPropertyDescription.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to fetch ai_property_description',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.notFound,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all ai_property_descriptions with pagination and filtering
  /// Returns list of [AiPropertyDescription] objects
  Future<List<AiPropertyDescription>> getai_property_descriptions({
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
      
      final response = await _dioClient.get('/api/v1/ai_property_description', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => AiPropertyDescription.fromJson(item)).toList();
      } else {
        throw RepositoryException(
          message: 'Failed to fetch ai_property_descriptions',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new AiPropertyDescription
  /// Returns created [AiPropertyDescription] object
  Future<AiPropertyDescription> createAiPropertyDescription(AiPropertyDescription aiPropertyDescription) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/ai_property_description',
        data: aiPropertyDescription.toJson(),
      );
      return AiPropertyDescription.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update AiPropertyDescription
  Future<AiPropertyDescription> updateAiPropertyDescription(String id, AiPropertyDescription aiPropertyDescription) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/ai_property_description/$id',
        data: aiPropertyDescription.toJson(),
      );
      return AiPropertyDescription.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete AiPropertyDescription
  Future<void> deleteAiPropertyDescription(String id) async {
    try {
      await _dioClient.delete('/api/v1/ai_property_description/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    // Implement error handling logic here
    return Exception('API Error: ${e.message}');
  }
}
