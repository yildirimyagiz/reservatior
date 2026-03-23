import '../../features/shared/services/health_check_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for HealthCheck

class GetHealthCheckByIdUseCase {
  final HealthCheckService _service;
  
  GetHealthCheckByIdUseCase(this._service);
  
  Future<HealthCheck> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetHealthChecksUseCase {
  final HealthCheckService _service;
  
  GetHealthChecksUseCase(this._service);
  
  Future<List<HealthCheck>> execute({
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

class CreateHealthCheckUseCase {
  final HealthCheckService _service;
  
  CreateHealthCheckUseCase(this._service);
  
  Future<HealthCheck> execute(HealthCheck healthCheck) async {
    // Add validation logic here
    return await _service.create(healthCheck);
  }
}

class UpdateHealthCheckUseCase {
  final HealthCheckService _service;
  
  UpdateHealthCheckUseCase(this._service);
  
  Future<HealthCheck> execute(String id, HealthCheck healthCheck) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, healthCheck);
  }
}

class DeleteHealthCheckUseCase {
  final HealthCheckService _service;
  
  DeleteHealthCheckUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// HealthCheck Use Case Container
class HealthCheckUseCases {
  final GetHealthCheckByIdUseCase getById;
  final GetHealthChecksUseCase getAll;
  final CreateHealthCheckUseCase create;
  final UpdateHealthCheckUseCase update;
  final DeleteHealthCheckUseCase delete;
  
  HealthCheckUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory HealthCheckUseCases.create(HealthCheckService service) {
    return HealthCheckUseCases(
      getById: GetHealthCheckByIdUseCase(service),
      getAll: GetHealthChecksUseCase(service),
      create: CreateHealthCheckUseCase(service),
      update: UpdateHealthCheckUseCase(service),
      delete: DeleteHealthCheckUseCase(service),
    );
  }
}
