import '../../features/shared/services/system_metrics_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for SystemMetrics

class GetSystemMetricsByIdUseCase {
  final SystemMetricsService _service;
  
  GetSystemMetricsByIdUseCase(this._service);
  
  Future<SystemMetrics> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetSystemMetricssUseCase {
  final SystemMetricsService _service;
  
  GetSystemMetricssUseCase(this._service);
  
  Future<List<SystemMetrics>> execute({
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

class CreateSystemMetricsUseCase {
  final SystemMetricsService _service;
  
  CreateSystemMetricsUseCase(this._service);
  
  Future<SystemMetrics> execute(SystemMetrics systemMetrics) async {
    // Add validation logic here
    return await _service.create(systemMetrics);
  }
}

class UpdateSystemMetricsUseCase {
  final SystemMetricsService _service;
  
  UpdateSystemMetricsUseCase(this._service);
  
  Future<SystemMetrics> execute(String id, SystemMetrics systemMetrics) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, systemMetrics);
  }
}

class DeleteSystemMetricsUseCase {
  final SystemMetricsService _service;
  
  DeleteSystemMetricsUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// SystemMetrics Use Case Container
class SystemMetricsUseCases {
  final GetSystemMetricsByIdUseCase getById;
  final GetSystemMetricssUseCase getAll;
  final CreateSystemMetricsUseCase create;
  final UpdateSystemMetricsUseCase update;
  final DeleteSystemMetricsUseCase delete;
  
  SystemMetricsUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory SystemMetricsUseCases.create(SystemMetricsService service) {
    return SystemMetricsUseCases(
      getById: GetSystemMetricsByIdUseCase(service),
      getAll: GetSystemMetricssUseCase(service),
      create: CreateSystemMetricsUseCase(service),
      update: UpdateSystemMetricsUseCase(service),
      delete: DeleteSystemMetricsUseCase(service),
    );
  }
}
