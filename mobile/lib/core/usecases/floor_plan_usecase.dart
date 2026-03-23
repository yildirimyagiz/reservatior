import '../../features/shared/services/floor_plan_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for FloorPlan

class GetFloorPlanByIdUseCase {
  final FloorPlanService _service;
  
  GetFloorPlanByIdUseCase(this._service);
  
  Future<FloorPlan> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetFloorPlansUseCase {
  final FloorPlanService _service;
  
  GetFloorPlansUseCase(this._service);
  
  Future<List<FloorPlan>> execute({
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

class CreateFloorPlanUseCase {
  final FloorPlanService _service;
  
  CreateFloorPlanUseCase(this._service);
  
  Future<FloorPlan> execute(FloorPlan floorPlan) async {
    // Add validation logic here
    return await _service.create(floorPlan);
  }
}

class UpdateFloorPlanUseCase {
  final FloorPlanService _service;
  
  UpdateFloorPlanUseCase(this._service);
  
  Future<FloorPlan> execute(String id, FloorPlan floorPlan) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, floorPlan);
  }
}

class DeleteFloorPlanUseCase {
  final FloorPlanService _service;
  
  DeleteFloorPlanUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// FloorPlan Use Case Container
class FloorPlanUseCases {
  final GetFloorPlanByIdUseCase getById;
  final GetFloorPlansUseCase getAll;
  final CreateFloorPlanUseCase create;
  final UpdateFloorPlanUseCase update;
  final DeleteFloorPlanUseCase delete;
  
  FloorPlanUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory FloorPlanUseCases.create(FloorPlanService service) {
    return FloorPlanUseCases(
      getById: GetFloorPlanByIdUseCase(service),
      getAll: GetFloorPlansUseCase(service),
      create: CreateFloorPlanUseCase(service),
      update: UpdateFloorPlanUseCase(service),
      delete: DeleteFloorPlanUseCase(service),
    );
  }
}
