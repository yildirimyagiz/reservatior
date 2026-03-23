import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/repository_exception.dart';

/// Repository for MLConfiguration operations
/// Provides CRUD operations with proper error handling and type safety
class MLConfigurationRepository {
  final DioClient _dioClient;

  MLConfigurationRepository(this._dioClient);

  /// Get MLConfiguration by ID
  /// Returns [MLConfiguration] if found, throws [RepositoryException] otherwise
  Future<MLConfiguration> getMLConfigurationById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/m_l_configuration/$id');
      if (response.statusCode == 200) {
        return MLConfiguration.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to fetch m_l_configuration',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.notFound,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all m_l_configurations with pagination and filtering
  /// Returns list of [MLConfiguration] objects
  Future<List<MLConfiguration>> getm_l_configurations({
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
      
      final response = await _dioClient.get('/api/v1/m_l_configuration', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => MLConfiguration.fromJson(item)).toList();
      } else {
        throw RepositoryException(
          message: 'Failed to fetch m_l_configurations',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new MLConfiguration
  /// Returns created [MLConfiguration] object
  Future<MLConfiguration> createMLConfiguration(MLConfiguration mLConfiguration) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/m_l_configuration',
        data: mLConfiguration.toJson(),
      );
      return MLConfiguration.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update MLConfiguration
  Future<MLConfiguration> updateMLConfiguration(String id, MLConfiguration mLConfiguration) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/m_l_configuration/$id',
        data: mLConfiguration.toJson(),
      );
      return MLConfiguration.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete MLConfiguration
  Future<void> deleteMLConfiguration(String id) async {
    try {
      await _dioClient.delete('/api/v1/m_l_configuration/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    // Implement error handling logic here
    return Exception('API Error: ${e.message}');
  }
}
