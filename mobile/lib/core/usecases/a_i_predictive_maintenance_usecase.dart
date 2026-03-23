import '../../features/shared/services/ai_predictive_maintenance_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for AIPredictiveMaintenance

class GetAIPredictiveMaintenanceByIdUseCase {
  final AIPredictiveMaintenanceService _service;
  
  GetAIPredictiveMaintenanceByIdUseCase(this._service);
  
  Future<AIPredictiveMaintenance> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetAIPredictiveMaintenancesUseCase {
  final AIPredictiveMaintenanceService _service;
  
  GetAIPredictiveMaintenancesUseCase(this._service);
  
  Future<List<AIPredictiveMaintenance>> execute({
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

class CreateAIPredictiveMaintenanceUseCase {
  final AIPredictiveMaintenanceService _service;
  
  CreateAIPredictiveMaintenanceUseCase(this._service);
  
  Future<AIPredictiveMaintenance> execute(AIPredictiveMaintenance aIPredictiveMaintenance) async {
    // Add validation logic here
    return await _service.create(aIPredictiveMaintenance);
  }
}

class UpdateAIPredictiveMaintenanceUseCase {
  final AIPredictiveMaintenanceService _service;
  
  UpdateAIPredictiveMaintenanceUseCase(this._service);
  
  Future<AIPredictiveMaintenance> execute(String id, AIPredictiveMaintenance aIPredictiveMaintenance) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, aIPredictiveMaintenance);
  }
}

class DeleteAIPredictiveMaintenanceUseCase {
  final AIPredictiveMaintenanceService _service;
  
  DeleteAIPredictiveMaintenanceUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// AIPredictiveMaintenance Use Case Container
class AIPredictiveMaintenanceUseCases {
  final GetAIPredictiveMaintenanceByIdUseCase getById;
  final GetAIPredictiveMaintenancesUseCase getAll;
  final CreateAIPredictiveMaintenanceUseCase create;
  final UpdateAIPredictiveMaintenanceUseCase update;
  final DeleteAIPredictiveMaintenanceUseCase delete;
  
  AIPredictiveMaintenanceUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory AIPredictiveMaintenanceUseCases.create(AIPredictiveMaintenanceService service) {
    return AIPredictiveMaintenanceUseCases(
      getById: GetAIPredictiveMaintenanceByIdUseCase(service),
      getAll: GetAIPredictiveMaintenancesUseCase(service),
      create: CreateAIPredictiveMaintenanceUseCase(service),
      update: UpdateAIPredictiveMaintenanceUseCase(service),
      delete: DeleteAIPredictiveMaintenanceUseCase(service),
    );
  }
}
