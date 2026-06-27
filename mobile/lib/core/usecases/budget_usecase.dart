import 'package:reservatior/shared/repositories/budget_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetBudgetByIdUseCase {
  final BudgetRepository _repository;
  GetBudgetByIdUseCase(this._repository);
  Future<Budget> execute(String id) => _repository.getById(id);
}

class GetBudgetsUseCase {
  final BudgetRepository _repository;
  GetBudgetsUseCase(this._repository);
  Future<List<Budget>> execute({
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

class CreateBudgetUseCase {
  final BudgetRepository _repository;
  CreateBudgetUseCase(this._repository);
  Future<Budget> execute(Budget item) => _repository.create(item);
}

class UpdateBudgetUseCase {
  final BudgetRepository _repository;
  UpdateBudgetUseCase(this._repository);
  Future<Budget> execute(String id, Budget item) => _repository.update(id, item);
}

class DeleteBudgetUseCase {
  final BudgetRepository _repository;
  DeleteBudgetUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
