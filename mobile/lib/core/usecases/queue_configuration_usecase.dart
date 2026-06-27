import 'package:reservatior/shared/repositories/queue_configuration_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetQueueConfigurationByIdUseCase {
  final QueueConfigurationRepository _repository;
  GetQueueConfigurationByIdUseCase(this._repository);
  Future<QueueConfiguration> execute(String id) => _repository.getById(id);
}

class GetQueueConfigurationsUseCase {
  final QueueConfigurationRepository _repository;
  GetQueueConfigurationsUseCase(this._repository);
  Future<List<QueueConfiguration>> execute({
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

class CreateQueueConfigurationUseCase {
  final QueueConfigurationRepository _repository;
  CreateQueueConfigurationUseCase(this._repository);
  Future<QueueConfiguration> execute(QueueConfiguration item) => _repository.create(item);
}

class UpdateQueueConfigurationUseCase {
  final QueueConfigurationRepository _repository;
  UpdateQueueConfigurationUseCase(this._repository);
  Future<QueueConfiguration> execute(String id, QueueConfiguration item) => _repository.update(id, item);
}

class DeleteQueueConfigurationUseCase {
  final QueueConfigurationRepository _repository;
  DeleteQueueConfigurationUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
