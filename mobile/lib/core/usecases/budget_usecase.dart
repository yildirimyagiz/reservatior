import '../../features/shared/services/budget_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for Budget

class GetBudgetByIdUseCase {
  final BudgetService _service;
  
  GetBudgetByIdUseCase(this._service);
  
  Future<Budget> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetBudgetsUseCase {
  final BudgetService _service;
  
  GetBudgetsUseCase(this._service);
  
  Future<List<Budget>> execute({
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

class CreateBudgetUseCase {
  final BudgetService _service;
  
  CreateBudgetUseCase(this._service);
  
  Future<Budget> execute(Budget budget) async {
    // Add validation logic here
    return await _service.create(budget);
  }
}

class UpdateBudgetUseCase {
  final BudgetService _service;
  
  UpdateBudgetUseCase(this._service);
  
  Future<Budget> execute(String id, Budget budget) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, budget);
  }
}

class DeleteBudgetUseCase {
  final BudgetService _service;
  
  DeleteBudgetUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// Budget Use Case Container
class BudgetUseCases {
  final GetBudgetByIdUseCase getById;
  final GetBudgetsUseCase getAll;
  final CreateBudgetUseCase create;
  final UpdateBudgetUseCase update;
  final DeleteBudgetUseCase delete;
  
  BudgetUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory BudgetUseCases.create(BudgetService service) {
    return BudgetUseCases(
      getById: GetBudgetByIdUseCase(service),
      getAll: GetBudgetsUseCase(service),
      create: CreateBudgetUseCase(service),
      update: UpdateBudgetUseCase(service),
      delete: DeleteBudgetUseCase(service),
    );
  }
}
