import 'package:reservatior/shared/repositories/escrow_status_history_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetEscrowStatusHistoryByIdUseCase {
  final EscrowStatusHistoryRepository _repository;
  GetEscrowStatusHistoryByIdUseCase(this._repository);
  Future<EscrowStatusHistory> execute(String id) => _repository.getById(id);
}

class GetEscrowStatusHistorysUseCase {
  final EscrowStatusHistoryRepository _repository;
  GetEscrowStatusHistorysUseCase(this._repository);
  Future<List<EscrowStatusHistory>> execute({
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

class CreateEscrowStatusHistoryUseCase {
  final EscrowStatusHistoryRepository _repository;
  CreateEscrowStatusHistoryUseCase(this._repository);
  Future<EscrowStatusHistory> execute(EscrowStatusHistory item) => _repository.create(item);
}

class UpdateEscrowStatusHistoryUseCase {
  final EscrowStatusHistoryRepository _repository;
  UpdateEscrowStatusHistoryUseCase(this._repository);
  Future<EscrowStatusHistory> execute(String id, EscrowStatusHistory item) => _repository.update(id, item);
}

class DeleteEscrowStatusHistoryUseCase {
  final EscrowStatusHistoryRepository _repository;
  DeleteEscrowStatusHistoryUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
