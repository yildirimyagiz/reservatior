import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/repository_exception.dart';

/// Repository for AiPredictiveMaintenance operations
/// Provides CRUD operations with proper error handling and type safety
class AiPredictiveMaintenanceRepository {
  final DioClient _dioClient;

  AiPredictiveMaintenanceRepository(this._dioClient);

  /// Get AiPredictiveMaintenance by ID
  /// Returns [AiPredictiveMaintenance] if found, throws [RepositoryException] otherwise
  Future<AiPredictiveMaintenance> getAiPredictiveMaintenanceById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/ai_predictive_maintenance/$id');
      if (response.statusCode == 200) {
        return AiPredictiveMaintenance.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to fetch ai_predictive_maintenance',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.notFound,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all ai_predictive_maintenances with pagination and filtering
  /// Returns list of [AiPredictiveMaintenance] objects
  Future<List<AiPredictiveMaintenance>> getai_predictive_maintenances({
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
      
      final response = await _dioClient.get('/api/v1/ai_predictive_maintenance', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => AiPredictiveMaintenance.fromJson(item)).toList();
      } else {
        throw RepositoryException(
          message: 'Failed to fetch ai_predictive_maintenances',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new AiPredictiveMaintenance
  /// Returns created [AiPredictiveMaintenance] object
  Future<AiPredictiveMaintenance> createAiPredictiveMaintenance(AiPredictiveMaintenance aiPredictiveMaintenance) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/ai_predictive_maintenance',
        data: aiPredictiveMaintenance.toJson(),
      );
      return AiPredictiveMaintenance.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update AiPredictiveMaintenance
  Future<AiPredictiveMaintenance> updateAiPredictiveMaintenance(String id, AiPredictiveMaintenance aiPredictiveMaintenance) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/ai_predictive_maintenance/$id',
        data: aiPredictiveMaintenance.toJson(),
      );
      return AiPredictiveMaintenance.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete AiPredictiveMaintenance
  Future<void> deleteAiPredictiveMaintenance(String id) async {
    try {
      await _dioClient.delete('/api/v1/ai_predictive_maintenance/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    // Implement error handling logic here
    return Exception('API Error: ${e.message}');
  }
}
