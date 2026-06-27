import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class DashboardWidgetService {
  final DioClient _dioClient;
  DashboardWidgetService(this._dioClient);

  Future<DashboardWidget> getDashboardWidgetById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.dashboardWidgets}/$id');
    return DashboardWidget.fromJson(response.data['data']);
  }

  Future<List<DashboardWidget>> getDashboardWidgets({
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
    final response = await _dioClient.get(ApiEndpoints.dashboardWidgets, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => DashboardWidget.fromJson(json)).toList();
  }

  Future<DashboardWidget> createDashboardWidget(DashboardWidget item) async {
    final response = await _dioClient.post(ApiEndpoints.dashboardWidgets, data: item.toJson());
    return DashboardWidget.fromJson(response.data['data']);
  }

  Future<DashboardWidget> updateDashboardWidget(String id, DashboardWidget item) async {
    final response = await _dioClient.patch('${ApiEndpoints.dashboardWidgets}/$id', data: item.toJson());
    return DashboardWidget.fromJson(response.data['data']);
  }

  Future<void> deleteDashboardWidget(String id) async {
    await _dioClient.delete('${ApiEndpoints.dashboardWidgets}/$id');
  }
}
