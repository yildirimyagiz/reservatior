import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class AnalyticsService {
  final DioClient _dioClient;
  AnalyticsService(this._dioClient);

  Future<Analytics> getAnalyticsById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.analyticsEndpoint}/$id');
    return Analytics.fromJson(response.data['data']);
  }

  Future<List<Analytics>> getAnalyticses({
    int page = 1, 
    int limit = 20, 
    String? orgId,
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) async {
    final queryParams = {
      'page': page, 
      'limit': limit,
      if (orgId != null) 'orgId': orgId,
      if (sortBy != null) 'sortBy': sortBy,
      if (sortOrder != null) 'sortOrder': sortOrder,
      ...?filters
    };
    final response = await _dioClient.get(ApiEndpoints.analyticsEndpoint, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => Analytics.fromJson(json)).toList();
  }

  Future<Analytics> createAnalytics(Analytics item) async {
    final response = await _dioClient.post(ApiEndpoints.analyticsEndpoint, data: item.toJson());
    return Analytics.fromJson(response.data['data']);
  }

  Future<Analytics> updateAnalytics(String id, Analytics item) async {
    final response = await _dioClient.patch('${ApiEndpoints.analyticsEndpoint}/$id', data: item.toJson());
    return Analytics.fromJson(response.data['data']);
  }

  Future<void> deleteAnalytics(String id) async {
    await _dioClient.delete('${ApiEndpoints.analyticsEndpoint}/$id');
  }

  Future<DashboardStats> getDashboardStats(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.analyticsEndpoint}/$id/dashboard-stats');
    return DashboardStats.fromJson(response.data['data']);
  }

  Future<void> logUserBehavior(String event, Map<String, dynamic> metadata) async {
    await _dioClient.post('${ApiEndpoints.analyticsEndpoint}/behavior/log', data: {
      'event': event,
      'metadata': metadata,
      'timestamp': DateTime.now().toIso8601String(),
    });
  }

  Future<Map<String, dynamic>> getRealTimeMetrics() async {
    final response = await _dioClient.get('${ApiEndpoints.analyticsEndpoint}/realtime');
    return Map<String, dynamic>.from(response.data['data']);
  }

  Future<void> logSessionRecording(String sessionId, dynamic recordingData) async {
    await _dioClient.post('${ApiEndpoints.analyticsEndpoint}/session/upload', data: {
      'sessionId': sessionId,
      'data': recordingData,
    });
  }
}
