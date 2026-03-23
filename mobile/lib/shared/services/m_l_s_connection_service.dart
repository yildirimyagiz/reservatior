import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class MLSConnectionService {
  final DioClient _dioClient;

  MLSConnectionService(this._dioClient);

  // Get MLSConnection by ID
  Future<MLSConnection> getMLSConnectionById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/m_l_s_connection/$id');
      return MLSConnection.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all m_l_s_connections
  Future<List<MLSConnection>> getMLSConnections({
    int page = 1,
    int limit = 20,
    Map<String, dynamic>? filters,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'page': page.toString(),
        'limit': limit.toString(),
      };

      if (filters != null) {
        queryParams.addAll(filters);
      }

      final response = await _dioClient.get('/api/v1/m_l_s_connection', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => MLSConnection.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create MLSConnection
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
    return Exception('API Error: ${e.message}');
  }
}
