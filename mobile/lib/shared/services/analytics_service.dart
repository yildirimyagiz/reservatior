import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class AnalyticsService {
  final DioClient _dioClient;

  AnalyticsService(this._dioClient);

  // Get Analytics by ID
  Future<Analytics> getAnalyticsById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/analytics/$id');
      return Analytics.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all analyticss
  Future<List<Analytics>> getAnalyticss({
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

      final response = await _dioClient.get('/api/v1/analytics', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => Analytics.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create Analytics
  Future<Analytics> createAnalytics(Analytics analytics) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/analytics',
        data: analytics.toJson(),
      );
      return Analytics.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update Analytics
  Future<Analytics> updateAnalytics(String id, Analytics analytics) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/analytics/$id',
        data: analytics.toJson(),
      );
      return Analytics.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete Analytics
  Future<void> deleteAnalytics(String id) async {
    try {
      await _dioClient.delete('/api/v1/analytics/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
