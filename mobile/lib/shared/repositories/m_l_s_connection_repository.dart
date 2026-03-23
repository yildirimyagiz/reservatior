import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/repository_exception.dart';

/// Repository for MLSConnection operations
/// Provides CRUD operations with proper error handling and type safety
class MLSConnectionRepository {
  final DioClient _dioClient;

  MLSConnectionRepository(this._dioClient);

  /// Get MLSConnection by ID
  /// Returns [MLSConnection] if found, throws [RepositoryException] otherwise
  Future<MLSConnection> getMLSConnectionById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/m_l_s_connection/$id');
      if (response.statusCode == 200) {
        return MLSConnection.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to fetch m_l_s_connection',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.notFound,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all m_l_s_connections with pagination and filtering
  /// Returns list of [MLSConnection] objects
  Future<List<MLSConnection>> getm_l_s_connections({
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
      
      final response = await _dioClient.get('/api/v1/m_l_s_connection', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => MLSConnection.fromJson(item)).toList();
      } else {
        throw RepositoryException(
          message: 'Failed to fetch m_l_s_connections',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new MLSConnection
  /// Returns created [MLSConnection] object
  Future<MLSConnection> createMLSConnection(MLSConnection mLSConnection) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/m_l_s_connection',
        data: mLSConnection.toJson(),
      );
      return MLSConnection.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update MLSConnection
  Future<MLSConnection> updateMLSConnection(String id, MLSConnection mLSConnection) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/m_l_s_connection/$id',
        data: mLSConnection.toJson(),
      );
      return MLSConnection.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete MLSConnection
  Future<void> deleteMLSConnection(String id) async {
    try {
      await _dioClient.delete('/api/v1/m_l_s_connection/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    // Implement error handling logic here
    return Exception('API Error: ${e.message}');
  }
}
