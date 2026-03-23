import '../../features/shared/services/dashboard_configuration_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for DashboardConfiguration

class GetDashboardConfigurationByIdUseCase {
  final DashboardConfigurationService _service;
  
  GetDashboardConfigurationByIdUseCase(this._service);
  
  Future<DashboardConfiguration> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetDashboardConfigurationsUseCase {
  final DashboardConfigurationService _service;
  
  GetDashboardConfigurationsUseCase(this._service);
  
  Future<List<DashboardConfiguration>> execute({
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

class CreateDashboardConfigurationUseCase {
  final DashboardConfigurationService _service;
  
  CreateDashboardConfigurationUseCase(this._service);
  
  Future<DashboardConfiguration> execute(DashboardConfiguration dashboardConfiguration) async {
    // Add validation logic here
    return await _service.create(dashboardConfiguration);
  }
}

class UpdateDashboardConfigurationUseCase {
  final DashboardConfigurationService _service;
  
  UpdateDashboardConfigurationUseCase(this._service);
  
  Future<DashboardConfiguration> execute(String id, DashboardConfiguration dashboardConfiguration) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, dashboardConfiguration);
  }
}

class DeleteDashboardConfigurationUseCase {
  final DashboardConfigurationService _service;
  
  DeleteDashboardConfigurationUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// DashboardConfiguration Use Case Container
class DashboardConfigurationUseCases {
  final GetDashboardConfigurationByIdUseCase getById;
  final GetDashboardConfigurationsUseCase getAll;
  final CreateDashboardConfigurationUseCase create;
  final UpdateDashboardConfigurationUseCase update;
  final DeleteDashboardConfigurationUseCase delete;
  
  DashboardConfigurationUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory DashboardConfigurationUseCases.create(DashboardConfigurationService service) {
    return DashboardConfigurationUseCases(
      getById: GetDashboardConfigurationByIdUseCase(service),
      getAll: GetDashboardConfigurationsUseCase(service),
      create: CreateDashboardConfigurationUseCase(service),
      update: UpdateDashboardConfigurationUseCase(service),
      delete: DeleteDashboardConfigurationUseCase(service),
    );
  }
}
