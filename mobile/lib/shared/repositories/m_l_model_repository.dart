import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/repository_exception.dart';

/// Repository for MLModel operations
/// Provides CRUD operations with proper error handling and type safety
class MLModelRepository {
  final DioClient _dioClient;

  MLModelRepository(this._dioClient);

  /// Get MLModel by ID
  /// Returns [MLModel] if found, throws [RepositoryException] otherwise
  Future<MLModel> getMLModelById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/m_l_model/$id');
      if (response.statusCode == 200) {
        return MLModel.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to fetch m_l_model',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.notFound,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all m_l_models with pagination and filtering
  /// Returns list of [MLModel] objects
  Future<List<MLModel>> getm_l_models({
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
      
      final response = await _dioClient.get('/api/v1/m_l_model', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => MLModel.fromJson(item)).toList();
      } else {
        throw RepositoryException(
          message: 'Failed to fetch m_l_models',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new MLModel
  /// Returns created [MLModel] object
  Future<MLModel> createMLModel(MLModel mLModel) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/m_l_model',
        data: mLModel.toJson(),
      );
      return MLModel.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update MLModel
  Future<MLModel> updateMLModel(String id, MLModel mLModel) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/m_l_model/$id',
        data: mLModel.toJson(),
      );
      return MLModel.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete MLModel
  Future<void> deleteMLModel(String id) async {
    try {
      await _dioClient.delete('/api/v1/m_l_model/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    // Implement error handling logic here
    return Exception('API Error: ${e.message}');
  }
}
