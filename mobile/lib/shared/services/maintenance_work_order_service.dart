import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class MaintenanceWorkOrderService {
  final DioClient _dioClient;
  MaintenanceWorkOrderService(this._dioClient);

  Future<MaintenanceWorkOrder> getMaintenanceWorkOrderById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.maintenanceWorkOrders}/$id');
    return MaintenanceWorkOrder.fromJson(response.data['data']);
  }

  Future<List<MaintenanceWorkOrder>> getMaintenanceWorkOrders({
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
    final response = await _dioClient.get(ApiEndpoints.maintenanceWorkOrders, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => MaintenanceWorkOrder.fromJson(json)).toList();
  }

  Future<MaintenanceWorkOrder> createMaintenanceWorkOrder(MaintenanceWorkOrder item) async {
    final response = await _dioClient.post(ApiEndpoints.maintenanceWorkOrders, data: item.toJson());
    return MaintenanceWorkOrder.fromJson(response.data['data']);
  }

  Future<MaintenanceWorkOrder> updateMaintenanceWorkOrder(String id, MaintenanceWorkOrder item) async {
    final response = await _dioClient.patch('${ApiEndpoints.maintenanceWorkOrders}/$id', data: item.toJson());
    return MaintenanceWorkOrder.fromJson(response.data['data']);
  }

  Future<void> deleteMaintenanceWorkOrder(String id) async {
    await _dioClient.delete('${ApiEndpoints.maintenanceWorkOrders}/$id');
  }
}
