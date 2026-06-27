import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/expense_service.dart';

abstract class ExpenseRepository {
  Future<Expense> getById(String id);
  Future<List<Expense>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<Expense> create(Expense item);
  Future<Expense> update(String id, Expense item);
  Future<void> delete(String id);
}

class ExpenseRepositoryImpl implements ExpenseRepository {
  final ExpenseService _service;
  ExpenseRepositoryImpl(this._service);

  @override
  Future<Expense> getById(String id) => _service.getExpenseById(id);

  @override
  Future<List<Expense>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getExpenses(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<Expense> create(Expense item) => _service.createExpense(item);

  @override
  Future<Expense> update(String id, Expense item) => _service.updateExpense(id, item);

  @override
  Future<void> delete(String id) => _service.deleteExpense(id);
}
