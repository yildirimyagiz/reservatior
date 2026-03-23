import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class MaintenanceWorkOrderService {
  final DioClient _dioClient;

  MaintenanceWorkOrderService(this._dioClient);

  // Get MaintenanceWorkOrder by ID
  Future<MaintenanceWorkOrder> getMaintenanceWorkOrderById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/maintenance_work_order/$id');
      return MaintenanceWorkOrder.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all maintenance_work_orders
  Future<List<MaintenanceWorkOrder>> getMaintenanceWorkOrders({
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

      final response = await _dioClient.get('/api/v1/maintenance_work_order', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => MaintenanceWorkOrder.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create MaintenanceWorkOrder
  Future<MaintenanceWorkOrder> createMaintenanceWorkOrder(MaintenanceWorkOrder maintenanceWorkOrder) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/maintenance_work_order',
        data: maintenanceWorkOrder.toJson(),
      );
      return MaintenanceWorkOrder.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update MaintenanceWorkOrder
  Future<MaintenanceWorkOrder> updateMaintenanceWorkOrder(String id, MaintenanceWorkOrder maintenanceWorkOrder) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/maintenance_work_order/$id',
        data: maintenanceWorkOrder.toJson(),
      );
      return MaintenanceWorkOrder.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete MaintenanceWorkOrder
  Future<void> deleteMaintenanceWorkOrder(String id) async {
    try {
      await _dioClient.delete('/api/v1/maintenance_work_order/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
