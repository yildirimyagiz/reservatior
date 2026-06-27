import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/plan_service.dart';

abstract class PlanRepository {
  Future<Plan> getById(String id);
  Future<List<Plan>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<Plan> create(Plan item);
  Future<Plan> update(String id, Plan item);
  Future<void> delete(String id);
}

class PlanRepositoryImpl implements PlanRepository {
  final PlanService _service;
  PlanRepositoryImpl(this._service);

  @override
  Future<Plan> getById(String id) => _service.getPlanById(id);

  @override
  Future<List<Plan>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getPlans(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<Plan> create(Plan item) => _service.createPlan(item);

  @override
  Future<Plan> update(String id, Plan item) => _service.updatePlan(id, item);

  @override
  Future<void> delete(String id) => _service.deletePlan(id);
}
