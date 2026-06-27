import 'package:reservatior/shared/repositories/rental_sync_job_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetRentalSyncJobByIdUseCase {
  final RentalSyncJobRepository _repository;
  GetRentalSyncJobByIdUseCase(this._repository);
  Future<RentalSyncJob> execute(String id) => _repository.getById(id);
}

class GetRentalSyncJobsUseCase {
  final RentalSyncJobRepository _repository;
  GetRentalSyncJobsUseCase(this._repository);
  Future<List<RentalSyncJob>> execute({
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

class CreateRentalSyncJobUseCase {
  final RentalSyncJobRepository _repository;
  CreateRentalSyncJobUseCase(this._repository);
  Future<RentalSyncJob> execute(RentalSyncJob item) => _repository.create(item);
}

class UpdateRentalSyncJobUseCase {
  final RentalSyncJobRepository _repository;
  UpdateRentalSyncJobUseCase(this._repository);
  Future<RentalSyncJob> execute(String id, RentalSyncJob item) => _repository.update(id, item);
}

class DeleteRentalSyncJobUseCase {
  final RentalSyncJobRepository _repository;
  DeleteRentalSyncJobUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
