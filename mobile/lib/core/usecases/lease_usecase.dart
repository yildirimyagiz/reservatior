import '../../features/shared/services/lease_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for Lease

class GetLeaseByIdUseCase {
  final LeaseService _service;
  
  GetLeaseByIdUseCase(this._service);
  
  Future<Lease> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetLeasesUseCase {
  final LeaseService _service;
  
  GetLeasesUseCase(this._service);
  
  Future<List<Lease>> execute({
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

class CreateLeaseUseCase {
  final LeaseService _service;
  
  CreateLeaseUseCase(this._service);
  
  Future<Lease> execute(Lease lease) async {
    // Add validation logic here
    return await _service.create(lease);
  }
}

class UpdateLeaseUseCase {
  final LeaseService _service;
  
  UpdateLeaseUseCase(this._service);
  
  Future<Lease> execute(String id, Lease lease) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, lease);
  }
}

class DeleteLeaseUseCase {
  final LeaseService _service;
  
  DeleteLeaseUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// Lease Use Case Container
class LeaseUseCases {
  final GetLeaseByIdUseCase getById;
  final GetLeasesUseCase getAll;
  final CreateLeaseUseCase create;
  final UpdateLeaseUseCase update;
  final DeleteLeaseUseCase delete;
  
  LeaseUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory LeaseUseCases.create(LeaseService service) {
    return LeaseUseCases(
      getById: GetLeaseByIdUseCase(service),
      getAll: GetLeasesUseCase(service),
      create: CreateLeaseUseCase(service),
      update: UpdateLeaseUseCase(service),
      delete: DeleteLeaseUseCase(service),
    );
  }
}
