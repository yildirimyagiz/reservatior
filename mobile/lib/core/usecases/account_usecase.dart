import '../../features/shared/services/account_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for Account

class GetAccountByIdUseCase {
  final AccountService _service;
  
  GetAccountByIdUseCase(this._service);
  
  Future<Account> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetAccountsUseCase {
  final AccountService _service;
  
  GetAccountsUseCase(this._service);
  
  Future<List<Account>> execute({
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

class CreateAccountUseCase {
  final AccountService _service;
  
  CreateAccountUseCase(this._service);
  
  Future<Account> execute(Account account) async {
    // Add validation logic here
    return await _service.create(account);
  }
}

class UpdateAccountUseCase {
  final AccountService _service;
  
  UpdateAccountUseCase(this._service);
  
  Future<Account> execute(String id, Account account) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, account);
  }
}

class DeleteAccountUseCase {
  final AccountService _service;
  
  DeleteAccountUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// Account Use Case Container
class AccountUseCases {
  final GetAccountByIdUseCase getById;
  final GetAccountsUseCase getAll;
  final CreateAccountUseCase create;
  final UpdateAccountUseCase update;
  final DeleteAccountUseCase delete;
  
  AccountUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory AccountUseCases.create(AccountService service) {
    return AccountUseCases(
      getById: GetAccountByIdUseCase(service),
      getAll: GetAccountsUseCase(service),
      create: CreateAccountUseCase(service),
      update: UpdateAccountUseCase(service),
      delete: DeleteAccountUseCase(service),
    );
  }
}
