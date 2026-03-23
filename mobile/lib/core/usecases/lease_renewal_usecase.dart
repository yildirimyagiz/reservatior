import '../../features/shared/services/lease_renewal_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for LeaseRenewal

class GetLeaseRenewalByIdUseCase {
  final LeaseRenewalService _service;
  
  GetLeaseRenewalByIdUseCase(this._service);
  
  Future<LeaseRenewal> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetLeaseRenewalsUseCase {
  final LeaseRenewalService _service;
  
  GetLeaseRenewalsUseCase(this._service);
  
  Future<List<LeaseRenewal>> execute({
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

class CreateLeaseRenewalUseCase {
  final LeaseRenewalService _service;
  
  CreateLeaseRenewalUseCase(this._service);
  
  Future<LeaseRenewal> execute(LeaseRenewal leaseRenewal) async {
    // Add validation logic here
    return await _service.create(leaseRenewal);
  }
}

class UpdateLeaseRenewalUseCase {
  final LeaseRenewalService _service;
  
  UpdateLeaseRenewalUseCase(this._service);
  
  Future<LeaseRenewal> execute(String id, LeaseRenewal leaseRenewal) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, leaseRenewal);
  }
}

class DeleteLeaseRenewalUseCase {
  final LeaseRenewalService _service;
  
  DeleteLeaseRenewalUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// LeaseRenewal Use Case Container
class LeaseRenewalUseCases {
  final GetLeaseRenewalByIdUseCase getById;
  final GetLeaseRenewalsUseCase getAll;
  final CreateLeaseRenewalUseCase create;
  final UpdateLeaseRenewalUseCase update;
  final DeleteLeaseRenewalUseCase delete;
  
  LeaseRenewalUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory LeaseRenewalUseCases.create(LeaseRenewalService service) {
    return LeaseRenewalUseCases(
      getById: GetLeaseRenewalByIdUseCase(service),
      getAll: GetLeaseRenewalsUseCase(service),
      create: CreateLeaseRenewalUseCase(service),
      update: UpdateLeaseRenewalUseCase(service),
      delete: DeleteLeaseRenewalUseCase(service),
    );
  }
}
