import 'package:reservatior/shared/repositories/ai_predictive_maintenance_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetAiPredictiveMaintenanceByIdUseCase {
  final AiPredictiveMaintenanceRepository _repository;
  GetAiPredictiveMaintenanceByIdUseCase(this._repository);
  Future<AiPredictiveMaintenance> execute(String id) => _repository.getById(id);
}

class GetAiPredictiveMaintenancesUseCase {
  final AiPredictiveMaintenanceRepository _repository;
  GetAiPredictiveMaintenancesUseCase(this._repository);
  Future<List<AiPredictiveMaintenance>> execute({
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

class CreateAiPredictiveMaintenanceUseCase {
  final AiPredictiveMaintenanceRepository _repository;
  CreateAiPredictiveMaintenanceUseCase(this._repository);
  Future<AiPredictiveMaintenance> execute(AiPredictiveMaintenance item) => _repository.create(item);
}

class UpdateAiPredictiveMaintenanceUseCase {
  final AiPredictiveMaintenanceRepository _repository;
  UpdateAiPredictiveMaintenanceUseCase(this._repository);
  Future<AiPredictiveMaintenance> execute(String id, AiPredictiveMaintenance item) => _repository.update(id, item);
}

class DeleteAiPredictiveMaintenanceUseCase {
  final AiPredictiveMaintenanceRepository _repository;
  DeleteAiPredictiveMaintenanceUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
