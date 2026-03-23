import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/repository_exception.dart';

/// Repository for AiTenantScreening operations
/// Provides CRUD operations with proper error handling and type safety
class AiTenantScreeningRepository {
  final DioClient _dioClient;

  AiTenantScreeningRepository(this._dioClient);

  /// Get AiTenantScreening by ID
  /// Returns [AiTenantScreening] if found, throws [RepositoryException] otherwise
  Future<AiTenantScreening> getAiTenantScreeningById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/ai_tenant_screening/$id');
      if (response.statusCode == 200) {
        return AiTenantScreening.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to fetch ai_tenant_screening',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.notFound,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all ai_tenant_screenings with pagination and filtering
  /// Returns list of [AiTenantScreening] objects
  Future<List<AiTenantScreening>> getai_tenant_screenings({
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
      
      final response = await _dioClient.get('/api/v1/ai_tenant_screening', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => AiTenantScreening.fromJson(item)).toList();
      } else {
        throw RepositoryException(
          message: 'Failed to fetch ai_tenant_screenings',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new AiTenantScreening
  /// Returns created [AiTenantScreening] object
  Future<AiTenantScreening> createAiTenantScreening(AiTenantScreening aiTenantScreening) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/ai_tenant_screening',
        data: aiTenantScreening.toJson(),
      );
      return AiTenantScreening.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update AiTenantScreening
  Future<AiTenantScreening> updateAiTenantScreening(String id, AiTenantScreening aiTenantScreening) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/ai_tenant_screening/$id',
        data: aiTenantScreening.toJson(),
      );
      return AiTenantScreening.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete AiTenantScreening
  Future<void> deleteAiTenantScreening(String id) async {
    try {
      await _dioClient.delete('/api/v1/ai_tenant_screening/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    // Implement error handling logic here
    return Exception('API Error: ${e.message}');
  }
}
