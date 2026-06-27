import 'package:reservatior/shared/repositories/mls_sync_job_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetMlsSyncJobByIdUseCase {
  final MlsSyncJobRepository _repository;
  GetMlsSyncJobByIdUseCase(this._repository);
  Future<MlsSyncJob> execute(String id) => _repository.getById(id);
}

class GetMlsSyncJobsUseCase {
  final MlsSyncJobRepository _repository;
  GetMlsSyncJobsUseCase(this._repository);
  Future<List<MlsSyncJob>> execute({
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

class CreateMlsSyncJobUseCase {
  final MlsSyncJobRepository _repository;
  CreateMlsSyncJobUseCase(this._repository);
  Future<MlsSyncJob> execute(MlsSyncJob item) => _repository.create(item);
}

class UpdateMlsSyncJobUseCase {
  final MlsSyncJobRepository _repository;
  UpdateMlsSyncJobUseCase(this._repository);
  Future<MlsSyncJob> execute(String id, MlsSyncJob item) => _repository.update(id, item);
}

class DeleteMlsSyncJobUseCase {
  final MlsSyncJobRepository _repository;
  DeleteMlsSyncJobUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
