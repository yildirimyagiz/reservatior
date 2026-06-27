import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/ai_predictive_maintenance_service.dart';

abstract class AiPredictiveMaintenanceRepository {
  Future<AiPredictiveMaintenance> getById(String id);
  Future<List<AiPredictiveMaintenance>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<AiPredictiveMaintenance> create(AiPredictiveMaintenance item);
  Future<AiPredictiveMaintenance> update(String id, AiPredictiveMaintenance item);
  Future<void> delete(String id);
}

class AiPredictiveMaintenanceRepositoryImpl implements AiPredictiveMaintenanceRepository {
  final AiPredictiveMaintenanceService _service;
  AiPredictiveMaintenanceRepositoryImpl(this._service);

  @override
  Future<AiPredictiveMaintenance> getById(String id) => _service.getAiPredictiveMaintenanceById(id);

  @override
  Future<List<AiPredictiveMaintenance>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getAiPredictiveMaintenances(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<AiPredictiveMaintenance> create(AiPredictiveMaintenance item) => _service.createAiPredictiveMaintenance(item);

  @override
  Future<AiPredictiveMaintenance> update(String id, AiPredictiveMaintenance item) => _service.updateAiPredictiveMaintenance(id, item);

  @override
  Future<void> delete(String id) => _service.deleteAiPredictiveMaintenance(id);
}
