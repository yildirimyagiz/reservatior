import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/maintenance_work_order_service.dart';

abstract class MaintenanceWorkOrderRepository {
  Future<MaintenanceWorkOrder> getById(String id);
  Future<List<MaintenanceWorkOrder>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<MaintenanceWorkOrder> create(MaintenanceWorkOrder item);
  Future<MaintenanceWorkOrder> update(String id, MaintenanceWorkOrder item);
  Future<void> delete(String id);
}

class MaintenanceWorkOrderRepositoryImpl implements MaintenanceWorkOrderRepository {
  final MaintenanceWorkOrderService _service;
  MaintenanceWorkOrderRepositoryImpl(this._service);

  @override
  Future<MaintenanceWorkOrder> getById(String id) => _service.getMaintenanceWorkOrderById(id);

  @override
  Future<List<MaintenanceWorkOrder>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getMaintenanceWorkOrders(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<MaintenanceWorkOrder> create(MaintenanceWorkOrder item) => _service.createMaintenanceWorkOrder(item);

  @override
  Future<MaintenanceWorkOrder> update(String id, MaintenanceWorkOrder item) => _service.updateMaintenanceWorkOrder(id, item);

  @override
  Future<void> delete(String id) => _service.deleteMaintenanceWorkOrder(id);
}
