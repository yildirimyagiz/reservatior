import 'package:reservatior/shared/repositories/escrow_release_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetEscrowReleaseByIdUseCase {
  final EscrowReleaseRepository _repository;
  GetEscrowReleaseByIdUseCase(this._repository);
  Future<EscrowRelease> execute(String id) => _repository.getById(id);
}

class GetEscrowReleasesUseCase {
  final EscrowReleaseRepository _repository;
  GetEscrowReleasesUseCase(this._repository);
  Future<List<EscrowRelease>> execute({
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

class CreateEscrowReleaseUseCase {
  final EscrowReleaseRepository _repository;
  CreateEscrowReleaseUseCase(this._repository);
  Future<EscrowRelease> execute(EscrowRelease item) => _repository.create(item);
}

class UpdateEscrowReleaseUseCase {
  final EscrowReleaseRepository _repository;
  UpdateEscrowReleaseUseCase(this._repository);
  Future<EscrowRelease> execute(String id, EscrowRelease item) => _repository.update(id, item);
}

class DeleteEscrowReleaseUseCase {
  final EscrowReleaseRepository _repository;
  DeleteEscrowReleaseUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
