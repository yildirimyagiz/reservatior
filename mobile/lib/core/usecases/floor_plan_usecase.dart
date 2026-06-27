import 'package:reservatior/shared/repositories/floor_plan_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetFloorPlanByIdUseCase {
  final FloorPlanRepository _repository;
  GetFloorPlanByIdUseCase(this._repository);
  Future<FloorPlan> execute(String id) => _repository.getById(id);
}

class GetFloorPlansUseCase {
  final FloorPlanRepository _repository;
  GetFloorPlansUseCase(this._repository);
  Future<List<FloorPlan>> execute({
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

class CreateFloorPlanUseCase {
  final FloorPlanRepository _repository;
  CreateFloorPlanUseCase(this._repository);
  Future<FloorPlan> execute(FloorPlan item) => _repository.create(item);
}

class UpdateFloorPlanUseCase {
  final FloorPlanRepository _repository;
  UpdateFloorPlanUseCase(this._repository);
  Future<FloorPlan> execute(String id, FloorPlan item) => _repository.update(id, item);
}

class DeleteFloorPlanUseCase {
  final FloorPlanRepository _repository;
  DeleteFloorPlanUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
