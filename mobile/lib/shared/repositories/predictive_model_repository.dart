import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/repository_exception.dart';

/// Repository for PredictiveModel operations
/// Provides CRUD operations with proper error handling and type safety
class PredictiveModelRepository {
  final DioClient _dioClient;

  PredictiveModelRepository(this._dioClient);

  /// Get PredictiveModel by ID
  /// Returns [PredictiveModel] if found, throws [RepositoryException] otherwise
  Future<PredictiveModel> getPredictiveModelById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/predictive_model/$id');
      if (response.statusCode == 200) {
        return PredictiveModel.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to fetch predictive_model',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.notFound,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all predictive_models with pagination and filtering
  /// Returns list of [PredictiveModel] objects
  Future<List<PredictiveModel>> getpredictive_models({
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
      
      final response = await _dioClient.get('/api/v1/predictive_model', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => PredictiveModel.fromJson(item)).toList();
      } else {
        throw RepositoryException(
          message: 'Failed to fetch predictive_models',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new PredictiveModel
  /// Returns created [PredictiveModel] object
  Future<PredictiveModel> createPredictiveModel(PredictiveModel predictiveModel) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/predictive_model',
        data: predictiveModel.toJson(),
      );
      return PredictiveModel.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update PredictiveModel
  Future<PredictiveModel> updatePredictiveModel(String id, PredictiveModel predictiveModel) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/predictive_model/$id',
        data: predictiveModel.toJson(),
      );
      return PredictiveModel.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete PredictiveModel
  Future<void> deletePredictiveModel(String id) async {
    try {
      await _dioClient.delete('/api/v1/predictive_model/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    // Implement error handling logic here
    return Exception('API Error: ${e.message}');
  }
}
