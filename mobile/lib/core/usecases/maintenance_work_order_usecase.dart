import 'package:reservatior/shared/repositories/maintenance_work_order_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetMaintenanceWorkOrderByIdUseCase {
  final MaintenanceWorkOrderRepository _repository;
  GetMaintenanceWorkOrderByIdUseCase(this._repository);
  Future<MaintenanceWorkOrder> execute(String id) => _repository.getById(id);
}

class GetMaintenanceWorkOrdersUseCase {
  final MaintenanceWorkOrderRepository _repository;
  GetMaintenanceWorkOrdersUseCase(this._repository);
  Future<List<MaintenanceWorkOrder>> execute({
    int page = 1, 
    int limit = 20, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) => _repository.getAll(
    page: page, 
    limit: limit, 
    filters: filters,
    sortBy: sortBy,
    sortOrder: sortOrder,
  );
}

class CreateMaintenanceWorkOrderUseCase {
  final MaintenanceWorkOrderRepository _repository;
  CreateMaintenanceWorkOrderUseCase(this._repository);
  Future<MaintenanceWorkOrder> execute(MaintenanceWorkOrder item) => _repository.create(item);
}

class UpdateMaintenanceWorkOrderUseCase {
  final MaintenanceWorkOrderRepository _repository;
  UpdateMaintenanceWorkOrderUseCase(this._repository);
  Future<MaintenanceWorkOrder> execute(String id, MaintenanceWorkOrder item) => _repository.update(id, item);
}

class DeleteMaintenanceWorkOrderUseCase {
  final MaintenanceWorkOrderRepository _repository;
  DeleteMaintenanceWorkOrderUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
