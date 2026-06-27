import 'package:reservatior/shared/repositories/lease_renewal_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetLeaseRenewalByIdUseCase {
  final LeaseRenewalRepository _repository;
  GetLeaseRenewalByIdUseCase(this._repository);
  Future<LeaseRenewal> execute(String id) => _repository.getById(id);
}

class GetLeaseRenewalsUseCase {
  final LeaseRenewalRepository _repository;
  GetLeaseRenewalsUseCase(this._repository);
  Future<List<LeaseRenewal>> execute({
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

class CreateLeaseRenewalUseCase {
  final LeaseRenewalRepository _repository;
  CreateLeaseRenewalUseCase(this._repository);
  Future<LeaseRenewal> execute(LeaseRenewal item) => _repository.create(item);
}

class UpdateLeaseRenewalUseCase {
  final LeaseRenewalRepository _repository;
  UpdateLeaseRenewalUseCase(this._repository);
  Future<LeaseRenewal> execute(String id, LeaseRenewal item) => _repository.update(id, item);
}

class DeleteLeaseRenewalUseCase {
  final LeaseRenewalRepository _repository;
  DeleteLeaseRenewalUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
