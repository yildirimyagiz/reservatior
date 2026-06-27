import 'package:reservatior/shared/repositories/immigration_status_check_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetImmigrationStatusCheckByIdUseCase {
  final ImmigrationStatusCheckRepository _repository;
  GetImmigrationStatusCheckByIdUseCase(this._repository);
  Future<ImmigrationStatusCheck> execute(String id) => _repository.getById(id);
}

class GetImmigrationStatusChecksUseCase {
  final ImmigrationStatusCheckRepository _repository;
  GetImmigrationStatusChecksUseCase(this._repository);
  Future<List<ImmigrationStatusCheck>> execute({
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

class CreateImmigrationStatusCheckUseCase {
  final ImmigrationStatusCheckRepository _repository;
  CreateImmigrationStatusCheckUseCase(this._repository);
  Future<ImmigrationStatusCheck> execute(ImmigrationStatusCheck item) => _repository.create(item);
}

class UpdateImmigrationStatusCheckUseCase {
  final ImmigrationStatusCheckRepository _repository;
  UpdateImmigrationStatusCheckUseCase(this._repository);
  Future<ImmigrationStatusCheck> execute(String id, ImmigrationStatusCheck item) => _repository.update(id, item);
}

class DeleteImmigrationStatusCheckUseCase {
  final ImmigrationStatusCheckRepository _repository;
  DeleteImmigrationStatusCheckUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
