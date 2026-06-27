import 'package:reservatior/shared/repositories/ml_configuration_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetMlConfigurationByIdUseCase {
  final MlConfigurationRepository _repository;
  GetMlConfigurationByIdUseCase(this._repository);
  Future<MlConfiguration> execute(String id) => _repository.getById(id);
}

class GetMlConfigurationsUseCase {
  final MlConfigurationRepository _repository;
  GetMlConfigurationsUseCase(this._repository);
  Future<List<MlConfiguration>> execute({
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

class CreateMlConfigurationUseCase {
  final MlConfigurationRepository _repository;
  CreateMlConfigurationUseCase(this._repository);
  Future<MlConfiguration> execute(MlConfiguration item) => _repository.create(item);
}

class UpdateMlConfigurationUseCase {
  final MlConfigurationRepository _repository;
  UpdateMlConfigurationUseCase(this._repository);
  Future<MlConfiguration> execute(String id, MlConfiguration item) => _repository.update(id, item);
}

class DeleteMlConfigurationUseCase {
  final MlConfigurationRepository _repository;
  DeleteMlConfigurationUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
