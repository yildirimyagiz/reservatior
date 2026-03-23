import '../../features/shared/services/maintenance_block_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for MaintenanceBlock

class GetMaintenanceBlockByIdUseCase {
  final MaintenanceBlockService _service;
  
  GetMaintenanceBlockByIdUseCase(this._service);
  
  Future<MaintenanceBlock> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetMaintenanceBlocksUseCase {
  final MaintenanceBlockService _service;
  
  GetMaintenanceBlocksUseCase(this._service);
  
  Future<List<MaintenanceBlock>> execute({
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

class CreateMaintenanceBlockUseCase {
  final MaintenanceBlockService _service;
  
  CreateMaintenanceBlockUseCase(this._service);
  
  Future<MaintenanceBlock> execute(MaintenanceBlock maintenanceBlock) async {
    // Add validation logic here
    return await _service.create(maintenanceBlock);
  }
}

class UpdateMaintenanceBlockUseCase {
  final MaintenanceBlockService _service;
  
  UpdateMaintenanceBlockUseCase(this._service);
  
  Future<MaintenanceBlock> execute(String id, MaintenanceBlock maintenanceBlock) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, maintenanceBlock);
  }
}

class DeleteMaintenanceBlockUseCase {
  final MaintenanceBlockService _service;
  
  DeleteMaintenanceBlockUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// MaintenanceBlock Use Case Container
class MaintenanceBlockUseCases {
  final GetMaintenanceBlockByIdUseCase getById;
  final GetMaintenanceBlocksUseCase getAll;
  final CreateMaintenanceBlockUseCase create;
  final UpdateMaintenanceBlockUseCase update;
  final DeleteMaintenanceBlockUseCase delete;
  
  MaintenanceBlockUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory MaintenanceBlockUseCases.create(MaintenanceBlockService service) {
    return MaintenanceBlockUseCases(
      getById: GetMaintenanceBlockByIdUseCase(service),
      getAll: GetMaintenanceBlocksUseCase(service),
      create: CreateMaintenanceBlockUseCase(service),
      update: UpdateMaintenanceBlockUseCase(service),
      delete: DeleteMaintenanceBlockUseCase(service),
    );
  }
}
