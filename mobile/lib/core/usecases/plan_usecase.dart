import 'package:reservatior/shared/repositories/plan_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetPlanByIdUseCase {
  final PlanRepository _repository;
  GetPlanByIdUseCase(this._repository);
  Future<Plan> execute(String id) => _repository.getById(id);
}

class GetPlansUseCase {
  final PlanRepository _repository;
  GetPlansUseCase(this._repository);
  Future<List<Plan>> execute({
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

class CreatePlanUseCase {
  final PlanRepository _repository;
  CreatePlanUseCase(this._repository);
  Future<Plan> execute(Plan item) => _repository.create(item);
}

class UpdatePlanUseCase {
  final PlanRepository _repository;
  UpdatePlanUseCase(this._repository);
  Future<Plan> execute(String id, Plan item) => _repository.update(id, item);
}

class DeletePlanUseCase {
  final PlanRepository _repository;
  DeletePlanUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
