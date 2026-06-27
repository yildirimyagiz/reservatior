import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/budget_service.dart';

abstract class BudgetRepository {
  Future<Budget> getById(String id);
  Future<List<Budget>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<Budget> create(Budget item);
  Future<Budget> update(String id, Budget item);
  Future<void> delete(String id);
}

class BudgetRepositoryImpl implements BudgetRepository {
  final BudgetService _service;
  BudgetRepositoryImpl(this._service);

  @override
  Future<Budget> getById(String id) => _service.getBudgetById(id);

  @override
  Future<List<Budget>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getBudgets(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<Budget> create(Budget item) => _service.createBudget(item);

  @override
  Future<Budget> update(String id, Budget item) => _service.updateBudget(id, item);

  @override
  Future<void> delete(String id) => _service.deleteBudget(id);
}
