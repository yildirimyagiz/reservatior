import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/repository_exception.dart';

/// Repository for MaintenanceWorkOrder operations
/// Provides CRUD operations with proper error handling and type safety
class MaintenanceWorkOrderRepository {
  final DioClient _dioClient;

  MaintenanceWorkOrderRepository(this._dioClient);

  /// Get MaintenanceWorkOrder by ID
  /// Returns [MaintenanceWorkOrder] if found, throws [RepositoryException] otherwise
  Future<MaintenanceWorkOrder> getMaintenanceWorkOrderById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/maintenance_work_order/$id');
      if (response.statusCode == 200) {
        return MaintenanceWorkOrder.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to fetch maintenance_work_order',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.notFound,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all maintenance_work_orders with pagination and filtering
  /// Returns list of [MaintenanceWorkOrder] objects
  Future<List<MaintenanceWorkOrder>> getmaintenance_work_orders({
    int page = 1,
    int limit = 20,
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'page': page,
        'limit': limit,
        if (sortBy != null) 'sort_by': sortBy,
        if (sortOrder != null) 'sort_order': sortOrder,
        ...?filters,
      };
      
      final response = await _dioClient.get('/api/v1/maintenance_work_order', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => MaintenanceWorkOrder.fromJson(item)).toList();
      } else {
        throw RepositoryException(
          message: 'Failed to fetch maintenance_work_orders',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new MaintenanceWorkOrder
  /// Returns created [MaintenanceWorkOrder] object
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
    // Implement error handling logic here
    return Exception('API Error: ${e.message}');
  }
}
