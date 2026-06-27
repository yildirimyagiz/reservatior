import 'package:reservatior/shared/repositories/account_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetAccountByIdUseCase {
  final AccountRepository _repository;
  GetAccountByIdUseCase(this._repository);
  Future<Account> execute(String id) => _repository.getById(id);
}

class GetAccountsUseCase {
  final AccountRepository _repository;
  GetAccountsUseCase(this._repository);
  Future<List<Account>> execute({
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

class CreateAccountUseCase {
  final AccountRepository _repository;
  CreateAccountUseCase(this._repository);
  Future<Account> execute(Account item) => _repository.create(item);
}

class UpdateAccountUseCase {
  final AccountRepository _repository;
  UpdateAccountUseCase(this._repository);
  Future<Account> execute(String id, Account item) => _repository.update(id, item);
}

class DeleteAccountUseCase {
  final AccountRepository _repository;
  DeleteAccountUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
