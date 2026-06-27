import 'package:reservatior/shared/repositories/expense_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetExpenseByIdUseCase {
  final ExpenseRepository _repository;
  GetExpenseByIdUseCase(this._repository);
  Future<Expense> execute(String id) => _repository.getById(id);
}

class GetExpensesUseCase {
  final ExpenseRepository _repository;
  GetExpensesUseCase(this._repository);
  Future<List<Expense>> execute({
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

class CreateExpenseUseCase {
  final ExpenseRepository _repository;
  CreateExpenseUseCase(this._repository);
  Future<Expense> execute(Expense item) => _repository.create(item);
}

class UpdateExpenseUseCase {
  final ExpenseRepository _repository;
  UpdateExpenseUseCase(this._repository);
  Future<Expense> execute(String id, Expense item) => _repository.update(id, item);
}

class DeleteExpenseUseCase {
  final ExpenseRepository _repository;
  DeleteExpenseUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
