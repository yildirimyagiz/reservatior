import 'package:reservatior/shared/repositories/health_check_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetHealthCheckByIdUseCase {
  final HealthCheckRepository _repository;
  GetHealthCheckByIdUseCase(this._repository);
  Future<HealthCheck> execute(String id) => _repository.getById(id);
}

class GetHealthChecksUseCase {
  final HealthCheckRepository _repository;
  GetHealthChecksUseCase(this._repository);
  Future<List<HealthCheck>> execute({
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

class CreateHealthCheckUseCase {
  final HealthCheckRepository _repository;
  CreateHealthCheckUseCase(this._repository);
  Future<HealthCheck> execute(HealthCheck item) => _repository.create(item);
}

class UpdateHealthCheckUseCase {
  final HealthCheckRepository _repository;
  UpdateHealthCheckUseCase(this._repository);
  Future<HealthCheck> execute(String id, HealthCheck item) => _repository.update(id, item);
}

class DeleteHealthCheckUseCase {
  final HealthCheckRepository _repository;
  DeleteHealthCheckUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
