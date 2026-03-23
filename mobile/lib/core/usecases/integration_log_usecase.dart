import '../../features/shared/services/integration_log_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for IntegrationLog

class GetIntegrationLogByIdUseCase {
  final IntegrationLogService _service;
  
  GetIntegrationLogByIdUseCase(this._service);
  
  Future<IntegrationLog> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetIntegrationLogsUseCase {
  final IntegrationLogService _service;
  
  GetIntegrationLogsUseCase(this._service);
  
  Future<List<IntegrationLog>> execute({
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

class CreateIntegrationLogUseCase {
  final IntegrationLogService _service;
  
  CreateIntegrationLogUseCase(this._service);
  
  Future<IntegrationLog> execute(IntegrationLog integrationLog) async {
    // Add validation logic here
    return await _service.create(integrationLog);
  }
}

class UpdateIntegrationLogUseCase {
  final IntegrationLogService _service;
  
  UpdateIntegrationLogUseCase(this._service);
  
  Future<IntegrationLog> execute(String id, IntegrationLog integrationLog) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, integrationLog);
  }
}

class DeleteIntegrationLogUseCase {
  final IntegrationLogService _service;
  
  DeleteIntegrationLogUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// IntegrationLog Use Case Container
class IntegrationLogUseCases {
  final GetIntegrationLogByIdUseCase getById;
  final GetIntegrationLogsUseCase getAll;
  final CreateIntegrationLogUseCase create;
  final UpdateIntegrationLogUseCase update;
  final DeleteIntegrationLogUseCase delete;
  
  IntegrationLogUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory IntegrationLogUseCases.create(IntegrationLogService service) {
    return IntegrationLogUseCases(
      getById: GetIntegrationLogByIdUseCase(service),
      getAll: GetIntegrationLogsUseCase(service),
      create: CreateIntegrationLogUseCase(service),
      update: UpdateIntegrationLogUseCase(service),
      delete: DeleteIntegrationLogUseCase(service),
    );
  }
}
