import '../../features/shared/services/performance_alert_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for PerformanceAlert

class GetPerformanceAlertByIdUseCase {
  final PerformanceAlertService _service;
  
  GetPerformanceAlertByIdUseCase(this._service);
  
  Future<PerformanceAlert> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetPerformanceAlertsUseCase {
  final PerformanceAlertService _service;
  
  GetPerformanceAlertsUseCase(this._service);
  
  Future<List<PerformanceAlert>> execute({
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

class CreatePerformanceAlertUseCase {
  final PerformanceAlertService _service;
  
  CreatePerformanceAlertUseCase(this._service);
  
  Future<PerformanceAlert> execute(PerformanceAlert performanceAlert) async {
    // Add validation logic here
    return await _service.create(performanceAlert);
  }
}

class UpdatePerformanceAlertUseCase {
  final PerformanceAlertService _service;
  
  UpdatePerformanceAlertUseCase(this._service);
  
  Future<PerformanceAlert> execute(String id, PerformanceAlert performanceAlert) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, performanceAlert);
  }
}

class DeletePerformanceAlertUseCase {
  final PerformanceAlertService _service;
  
  DeletePerformanceAlertUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// PerformanceAlert Use Case Container
class PerformanceAlertUseCases {
  final GetPerformanceAlertByIdUseCase getById;
  final GetPerformanceAlertsUseCase getAll;
  final CreatePerformanceAlertUseCase create;
  final UpdatePerformanceAlertUseCase update;
  final DeletePerformanceAlertUseCase delete;
  
  PerformanceAlertUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory PerformanceAlertUseCases.create(PerformanceAlertService service) {
    return PerformanceAlertUseCases(
      getById: GetPerformanceAlertByIdUseCase(service),
      getAll: GetPerformanceAlertsUseCase(service),
      create: CreatePerformanceAlertUseCase(service),
      update: UpdatePerformanceAlertUseCase(service),
      delete: DeletePerformanceAlertUseCase(service),
    );
  }
}
