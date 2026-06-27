import 'package:reservatior/shared/repositories/system_metrics_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetSystemMetricsByIdUseCase {
  final SystemMetricsRepository _repository;
  GetSystemMetricsByIdUseCase(this._repository);
  Future<SystemMetrics> execute(String id) => _repository.getById(id);
}

class GetSystemMetricssUseCase {
  final SystemMetricsRepository _repository;
  GetSystemMetricssUseCase(this._repository);
  Future<List<SystemMetrics>> execute({
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

class CreateSystemMetricsUseCase {
  final SystemMetricsRepository _repository;
  CreateSystemMetricsUseCase(this._repository);
  Future<SystemMetrics> execute(SystemMetrics item) => _repository.create(item);
}

class UpdateSystemMetricsUseCase {
  final SystemMetricsRepository _repository;
  UpdateSystemMetricsUseCase(this._repository);
  Future<SystemMetrics> execute(String id, SystemMetrics item) => _repository.update(id, item);
}

class DeleteSystemMetricsUseCase {
  final SystemMetricsRepository _repository;
  DeleteSystemMetricsUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
