import 'package:reservatior/shared/repositories/integration_log_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetIntegrationLogByIdUseCase {
  final IntegrationLogRepository _repository;
  GetIntegrationLogByIdUseCase(this._repository);
  Future<IntegrationLog> execute(String id) => _repository.getById(id);
}

class GetIntegrationLogsUseCase {
  final IntegrationLogRepository _repository;
  GetIntegrationLogsUseCase(this._repository);
  Future<List<IntegrationLog>> execute({
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

class CreateIntegrationLogUseCase {
  final IntegrationLogRepository _repository;
  CreateIntegrationLogUseCase(this._repository);
  Future<IntegrationLog> execute(IntegrationLog item) => _repository.create(item);
}

class UpdateIntegrationLogUseCase {
  final IntegrationLogRepository _repository;
  UpdateIntegrationLogUseCase(this._repository);
  Future<IntegrationLog> execute(String id, IntegrationLog item) => _repository.update(id, item);
}

class DeleteIntegrationLogUseCase {
  final IntegrationLogRepository _repository;
  DeleteIntegrationLogUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
