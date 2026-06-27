import 'package:reservatior/shared/repositories/escrow_dispute_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetEscrowDisputeByIdUseCase {
  final EscrowDisputeRepository _repository;
  GetEscrowDisputeByIdUseCase(this._repository);
  Future<EscrowDispute> execute(String id) => _repository.getById(id);
}

class GetEscrowDisputesUseCase {
  final EscrowDisputeRepository _repository;
  GetEscrowDisputesUseCase(this._repository);
  Future<List<EscrowDispute>> execute({
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

class CreateEscrowDisputeUseCase {
  final EscrowDisputeRepository _repository;
  CreateEscrowDisputeUseCase(this._repository);
  Future<EscrowDispute> execute(EscrowDispute item) => _repository.create(item);
}

class UpdateEscrowDisputeUseCase {
  final EscrowDisputeRepository _repository;
  UpdateEscrowDisputeUseCase(this._repository);
  Future<EscrowDispute> execute(String id, EscrowDispute item) => _repository.update(id, item);
}

class DeleteEscrowDisputeUseCase {
  final EscrowDisputeRepository _repository;
  DeleteEscrowDisputeUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
