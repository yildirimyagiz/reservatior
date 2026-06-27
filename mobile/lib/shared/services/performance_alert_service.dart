import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class PerformanceAlertService {
  final DioClient _dioClient;
  PerformanceAlertService(this._dioClient);

  Future<PerformanceAlert> getPerformanceAlertById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.performanceAlerts}/$id');
    return PerformanceAlert.fromJson(response.data['data']);
  }

  Future<List<PerformanceAlert>> getPerformanceAlerts({
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
    final response = await _dioClient.get(ApiEndpoints.performanceAlerts, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => PerformanceAlert.fromJson(json)).toList();
  }

  Future<PerformanceAlert> createPerformanceAlert(PerformanceAlert item) async {
    final response = await _dioClient.post(ApiEndpoints.performanceAlerts, data: item.toJson());
    return PerformanceAlert.fromJson(response.data['data']);
  }

  Future<PerformanceAlert> updatePerformanceAlert(String id, PerformanceAlert item) async {
    final response = await _dioClient.patch('${ApiEndpoints.performanceAlerts}/$id', data: item.toJson());
    return PerformanceAlert.fromJson(response.data['data']);
  }

  Future<void> deletePerformanceAlert(String id) async {
    await _dioClient.delete('${ApiEndpoints.performanceAlerts}/$id');
  }
}
