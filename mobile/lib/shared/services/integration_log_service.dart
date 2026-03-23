import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class IntegrationLogService {
  final DioClient _dioClient;

  IntegrationLogService(this._dioClient);

  // Get IntegrationLog by ID
  Future<IntegrationLog> getIntegrationLogById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/integration_log/$id');
      return IntegrationLog.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all integration_logs
  Future<List<IntegrationLog>> getIntegrationLogs({
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

      final response = await _dioClient.get('/api/v1/integration_log', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => IntegrationLog.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create IntegrationLog
  Future<IntegrationLog> createIntegrationLog(IntegrationLog integrationLog) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/integration_log',
        data: integrationLog.toJson(),
      );
      return IntegrationLog.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update IntegrationLog
  Future<IntegrationLog> updateIntegrationLog(String id, IntegrationLog integrationLog) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/integration_log/$id',
        data: integrationLog.toJson(),
      );
      return IntegrationLog.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete IntegrationLog
  Future<void> deleteIntegrationLog(String id) async {
    try {
      await _dioClient.delete('/api/v1/integration_log/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
