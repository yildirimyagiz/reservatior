import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/floor_plan_service.dart';

abstract class FloorPlanRepository {
  Future<FloorPlan> getById(String id);
  Future<List<FloorPlan>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<FloorPlan> create(FloorPlan item);
  Future<FloorPlan> update(String id, FloorPlan item);
  Future<void> delete(String id);
}

class FloorPlanRepositoryImpl implements FloorPlanRepository {
  final FloorPlanService _service;
  FloorPlanRepositoryImpl(this._service);

  @override
  Future<FloorPlan> getById(String id) => _service.getFloorPlanById(id);

  @override
  Future<List<FloorPlan>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getFloorPlans(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<FloorPlan> create(FloorPlan item) => _service.createFloorPlan(item);

  @override
  Future<FloorPlan> update(String id, FloorPlan item) => _service.updateFloorPlan(id, item);

  @override
  Future<void> delete(String id) => _service.deleteFloorPlan(id);
}
