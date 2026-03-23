import '../../features/shared/services/rental_sync_job_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for RentalSyncJob

class GetRentalSyncJobByIdUseCase {
  final RentalSyncJobService _service;
  
  GetRentalSyncJobByIdUseCase(this._service);
  
  Future<RentalSyncJob> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetRentalSyncJobsUseCase {
  final RentalSyncJobService _service;
  
  GetRentalSyncJobsUseCase(this._service);
  
  Future<List<RentalSyncJob>> execute({
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

class CreateRentalSyncJobUseCase {
  final RentalSyncJobService _service;
  
  CreateRentalSyncJobUseCase(this._service);
  
  Future<RentalSyncJob> execute(RentalSyncJob rentalSyncJob) async {
    // Add validation logic here
    return await _service.create(rentalSyncJob);
  }
}

class UpdateRentalSyncJobUseCase {
  final RentalSyncJobService _service;
  
  UpdateRentalSyncJobUseCase(this._service);
  
  Future<RentalSyncJob> execute(String id, RentalSyncJob rentalSyncJob) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, rentalSyncJob);
  }
}

class DeleteRentalSyncJobUseCase {
  final RentalSyncJobService _service;
  
  DeleteRentalSyncJobUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// RentalSyncJob Use Case Container
class RentalSyncJobUseCases {
  final GetRentalSyncJobByIdUseCase getById;
  final GetRentalSyncJobsUseCase getAll;
  final CreateRentalSyncJobUseCase create;
  final UpdateRentalSyncJobUseCase update;
  final DeleteRentalSyncJobUseCase delete;
  
  RentalSyncJobUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory RentalSyncJobUseCases.create(RentalSyncJobService service) {
    return RentalSyncJobUseCases(
      getById: GetRentalSyncJobByIdUseCase(service),
      getAll: GetRentalSyncJobsUseCase(service),
      create: CreateRentalSyncJobUseCase(service),
      update: UpdateRentalSyncJobUseCase(service),
      delete: DeleteRentalSyncJobUseCase(service),
    );
  }
}
