import '../../features/shared/services/expense_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for Expense

class GetExpenseByIdUseCase {
  final ExpenseService _service;
  
  GetExpenseByIdUseCase(this._service);
  
  Future<Expense> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetExpensesUseCase {
  final ExpenseService _service;
  
  GetExpensesUseCase(this._service);
  
  Future<List<Expense>> execute({
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

class CreateExpenseUseCase {
  final ExpenseService _service;
  
  CreateExpenseUseCase(this._service);
  
  Future<Expense> execute(Expense expense) async {
    // Add validation logic here
    return await _service.create(expense);
  }
}

class UpdateExpenseUseCase {
  final ExpenseService _service;
  
  UpdateExpenseUseCase(this._service);
  
  Future<Expense> execute(String id, Expense expense) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, expense);
  }
}

class DeleteExpenseUseCase {
  final ExpenseService _service;
  
  DeleteExpenseUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// Expense Use Case Container
class ExpenseUseCases {
  final GetExpenseByIdUseCase getById;
  final GetExpensesUseCase getAll;
  final CreateExpenseUseCase create;
  final UpdateExpenseUseCase update;
  final DeleteExpenseUseCase delete;
  
  ExpenseUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory ExpenseUseCases.create(ExpenseService service) {
    return ExpenseUseCases(
      getById: GetExpenseByIdUseCase(service),
      getAll: GetExpensesUseCase(service),
      create: CreateExpenseUseCase(service),
      update: UpdateExpenseUseCase(service),
      delete: DeleteExpenseUseCase(service),
    );
  }
}
