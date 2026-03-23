import '../../features/shared/services/plan_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for Plan

class GetPlanByIdUseCase {
  final PlanService _service;
  
  GetPlanByIdUseCase(this._service);
  
  Future<Plan> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetPlansUseCase {
  final PlanService _service;
  
  GetPlansUseCase(this._service);
  
  Future<List<Plan>> execute({
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

class CreatePlanUseCase {
  final PlanService _service;
  
  CreatePlanUseCase(this._service);
  
  Future<Plan> execute(Plan plan) async {
    // Add validation logic here
    return await _service.create(plan);
  }
}

class UpdatePlanUseCase {
  final PlanService _service;
  
  UpdatePlanUseCase(this._service);
  
  Future<Plan> execute(String id, Plan plan) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, plan);
  }
}

class DeletePlanUseCase {
  final PlanService _service;
  
  DeletePlanUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// Plan Use Case Container
class PlanUseCases {
  final GetPlanByIdUseCase getById;
  final GetPlansUseCase getAll;
  final CreatePlanUseCase create;
  final UpdatePlanUseCase update;
  final DeletePlanUseCase delete;
  
  PlanUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory PlanUseCases.create(PlanService service) {
    return PlanUseCases(
      getById: GetPlanByIdUseCase(service),
      getAll: GetPlansUseCase(service),
      create: CreatePlanUseCase(service),
      update: UpdatePlanUseCase(service),
      delete: DeletePlanUseCase(service),
    );
  }
}
