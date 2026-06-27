import 'package:reservatior/shared/repositories/escrow_account_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetEscrowAccountByIdUseCase {
  final EscrowAccountRepository _repository;
  GetEscrowAccountByIdUseCase(this._repository);
  Future<EscrowAccount> execute(String id) => _repository.getById(id);
}

class GetEscrowAccountsUseCase {
  final EscrowAccountRepository _repository;
  GetEscrowAccountsUseCase(this._repository);
  Future<List<EscrowAccount>> execute({
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

class CreateEscrowAccountUseCase {
  final EscrowAccountRepository _repository;
  CreateEscrowAccountUseCase(this._repository);
  Future<EscrowAccount> execute(EscrowAccount item) => _repository.create(item);
}

class UpdateEscrowAccountUseCase {
  final EscrowAccountRepository _repository;
  UpdateEscrowAccountUseCase(this._repository);
  Future<EscrowAccount> execute(String id, EscrowAccount item) => _repository.update(id, item);
}

class DeleteEscrowAccountUseCase {
  final EscrowAccountRepository _repository;
  DeleteEscrowAccountUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
