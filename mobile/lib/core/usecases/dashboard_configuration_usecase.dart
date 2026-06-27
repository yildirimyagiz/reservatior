import 'package:reservatior/shared/repositories/dashboard_configuration_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetDashboardConfigurationByIdUseCase {
  final DashboardConfigurationRepository _repository;
  GetDashboardConfigurationByIdUseCase(this._repository);
  Future<DashboardConfiguration> execute(String id) => _repository.getById(id);
}

class GetDashboardConfigurationsUseCase {
  final DashboardConfigurationRepository _repository;
  GetDashboardConfigurationsUseCase(this._repository);
  Future<List<DashboardConfiguration>> execute({
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

class CreateDashboardConfigurationUseCase {
  final DashboardConfigurationRepository _repository;
  CreateDashboardConfigurationUseCase(this._repository);
  Future<DashboardConfiguration> execute(DashboardConfiguration item) => _repository.create(item);
}

class UpdateDashboardConfigurationUseCase {
  final DashboardConfigurationRepository _repository;
  UpdateDashboardConfigurationUseCase(this._repository);
  Future<DashboardConfiguration> execute(String id, DashboardConfiguration item) => _repository.update(id, item);
}

class DeleteDashboardConfigurationUseCase {
  final DashboardConfigurationRepository _repository;
  DeleteDashboardConfigurationUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
