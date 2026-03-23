import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class PerformanceAlertService {
  final DioClient _dioClient;

  PerformanceAlertService(this._dioClient);

  // Get PerformanceAlert by ID
  Future<PerformanceAlert> getPerformanceAlertById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/performance_alert/$id');
      return PerformanceAlert.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all performance_alerts
  Future<List<PerformanceAlert>> getPerformanceAlerts({
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

      final response = await _dioClient.get('/api/v1/performance_alert', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => PerformanceAlert.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create PerformanceAlert
  Future<PerformanceAlert> createPerformanceAlert(PerformanceAlert performanceAlert) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/performance_alert',
        data: performanceAlert.toJson(),
      );
      return PerformanceAlert.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update PerformanceAlert
  Future<PerformanceAlert> updatePerformanceAlert(String id, PerformanceAlert performanceAlert) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/performance_alert/$id',
        data: performanceAlert.toJson(),
      );
      return PerformanceAlert.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete PerformanceAlert
  Future<void> deletePerformanceAlert(String id) async {
    try {
      await _dioClient.delete('/api/v1/performance_alert/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
