import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class SystemMetricsService {
  final DioClient _dioClient;

  SystemMetricsService(this._dioClient);

  // Get SystemMetrics by ID
  Future<SystemMetrics> getSystemMetricsById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/system_metrics/$id');
      return SystemMetrics.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all system_metricss
  Future<List<SystemMetrics>> getSystemMetricss({
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

      final response = await _dioClient.get('/api/v1/system_metrics', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => SystemMetrics.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create SystemMetrics
  Future<SystemMetrics> createSystemMetrics(SystemMetrics systemMetrics) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/system_metrics',
        data: systemMetrics.toJson(),
      );
      return SystemMetrics.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update SystemMetrics
  Future<SystemMetrics> updateSystemMetrics(String id, SystemMetrics systemMetrics) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/system_metrics/$id',
        data: systemMetrics.toJson(),
      );
      return SystemMetrics.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete SystemMetrics
  Future<void> deleteSystemMetrics(String id) async {
    try {
      await _dioClient.delete('/api/v1/system_metrics/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
