import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class HealthCheckService {
  final DioClient _dioClient;

  HealthCheckService(this._dioClient);

  // Get HealthCheck by ID
  Future<HealthCheck> getHealthCheckById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/health_check/$id');
      return HealthCheck.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all health_checks
  Future<List<HealthCheck>> getHealthChecks({
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

      final response = await _dioClient.get('/api/v1/health_check', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => HealthCheck.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create HealthCheck
  Future<HealthCheck> createHealthCheck(HealthCheck healthCheck) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/health_check',
        data: healthCheck.toJson(),
      );
      return HealthCheck.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update HealthCheck
  Future<HealthCheck> updateHealthCheck(String id, HealthCheck healthCheck) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/health_check/$id',
        data: healthCheck.toJson(),
      );
      return HealthCheck.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete HealthCheck
  Future<void> deleteHealthCheck(String id) async {
    try {
      await _dioClient.delete('/api/v1/health_check/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
