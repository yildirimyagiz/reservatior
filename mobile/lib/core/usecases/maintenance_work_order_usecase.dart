import '../../features/shared/services/maintenance_work_order_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for MaintenanceWorkOrder

class GetMaintenanceWorkOrderByIdUseCase {
  final MaintenanceWorkOrderService _service;
  
  GetMaintenanceWorkOrderByIdUseCase(this._service);
  
  Future<MaintenanceWorkOrder> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetMaintenanceWorkOrdersUseCase {
  final MaintenanceWorkOrderService _service;
  
  GetMaintenanceWorkOrdersUseCase(this._service);
  
  Future<List<MaintenanceWorkOrder>> execute({
    int page = 1,
    int limit = 20,
    Map<String, dynamic>? filters,
  }) async {
    if (page <= 0) {
      throw ArgumentError('Page must be greater than 0');
    }
    if (limit <= 0 || limit > 100) {
      throw ArgumentError('Limit must be between 1 and 100');
    }
    return await _service.getAll(
      page: page,
      limit: limit,
      filters: filters,
    );
  }
}

class CreateMaintenanceWorkOrderUseCase {
  final MaintenanceWorkOrderService _service;
  
  CreateMaintenanceWorkOrderUseCase(this._service);
  
  Future<MaintenanceWorkOrder> execute(MaintenanceWorkOrder maintenanceWorkOrder) async {
    // Add validation logic here
    return await _service.create(maintenanceWorkOrder);
  }
}

class UpdateMaintenanceWorkOrderUseCase {
  final MaintenanceWorkOrderService _service;
  
  UpdateMaintenanceWorkOrderUseCase(this._service);
  
  Future<MaintenanceWorkOrder> execute(String id, MaintenanceWorkOrder maintenanceWorkOrder) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, maintenanceWorkOrder);
  }
}

class DeleteMaintenanceWorkOrderUseCase {
  final MaintenanceWorkOrderService _service;
  
  DeleteMaintenanceWorkOrderUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// MaintenanceWorkOrder Use Case Container
class MaintenanceWorkOrderUseCases {
  final GetMaintenanceWorkOrderByIdUseCase getById;
  final GetMaintenanceWorkOrdersUseCase getAll;
  final CreateMaintenanceWorkOrderUseCase create;
  final UpdateMaintenanceWorkOrderUseCase update;
  final DeleteMaintenanceWorkOrderUseCase delete;
  
  MaintenanceWorkOrderUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory MaintenanceWorkOrderUseCases.create(MaintenanceWorkOrderService service) {
    return MaintenanceWorkOrderUseCases(
      getById: GetMaintenanceWorkOrderByIdUseCase(service),
      getAll: GetMaintenanceWorkOrdersUseCase(service),
      create: CreateMaintenanceWorkOrderUseCase(service),
      update: UpdateMaintenanceWorkOrderUseCase(service),
      delete: DeleteMaintenanceWorkOrderUseCase(service),
    );
  }
}
