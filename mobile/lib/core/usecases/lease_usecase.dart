import 'package:reservatior/shared/repositories/lease_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetLeaseByIdUseCase {
  final LeaseRepository _repository;
  GetLeaseByIdUseCase(this._repository);
  Future<Lease> execute(String id) => _repository.getById(id);
}

class GetLeasesUseCase {
  final LeaseRepository _repository;
  GetLeasesUseCase(this._repository);
  Future<List<Lease>> execute({
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

class CreateLeaseUseCase {
  final LeaseRepository _repository;
  CreateLeaseUseCase(this._repository);
  Future<Lease> execute(Lease item) => _repository.create(item);
}

class UpdateLeaseUseCase {
  final LeaseRepository _repository;
  UpdateLeaseUseCase(this._repository);
  Future<Lease> execute(String id, Lease item) => _repository.update(id, item);
}

class DeleteLeaseUseCase {
  final LeaseRepository _repository;
  DeleteLeaseUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
