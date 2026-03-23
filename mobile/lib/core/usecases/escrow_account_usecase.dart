import '../../features/shared/services/escrow_account_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for EscrowAccount

class GetEscrowAccountByIdUseCase {
  final EscrowAccountService _service;
  
  GetEscrowAccountByIdUseCase(this._service);
  
  Future<EscrowAccount> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetEscrowAccountsUseCase {
  final EscrowAccountService _service;
  
  GetEscrowAccountsUseCase(this._service);
  
  Future<List<EscrowAccount>> execute({
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

class CreateEscrowAccountUseCase {
  final EscrowAccountService _service;
  
  CreateEscrowAccountUseCase(this._service);
  
  Future<EscrowAccount> execute(EscrowAccount escrowAccount) async {
    // Add validation logic here
    return await _service.create(escrowAccount);
  }
}

class UpdateEscrowAccountUseCase {
  final EscrowAccountService _service;
  
  UpdateEscrowAccountUseCase(this._service);
  
  Future<EscrowAccount> execute(String id, EscrowAccount escrowAccount) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, escrowAccount);
  }
}

class DeleteEscrowAccountUseCase {
  final EscrowAccountService _service;
  
  DeleteEscrowAccountUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// EscrowAccount Use Case Container
class EscrowAccountUseCases {
  final GetEscrowAccountByIdUseCase getById;
  final GetEscrowAccountsUseCase getAll;
  final CreateEscrowAccountUseCase create;
  final UpdateEscrowAccountUseCase update;
  final DeleteEscrowAccountUseCase delete;
  
  EscrowAccountUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory EscrowAccountUseCases.create(EscrowAccountService service) {
    return EscrowAccountUseCases(
      getById: GetEscrowAccountByIdUseCase(service),
      getAll: GetEscrowAccountsUseCase(service),
      create: CreateEscrowAccountUseCase(service),
      update: UpdateEscrowAccountUseCase(service),
      delete: DeleteEscrowAccountUseCase(service),
    );
  }
}
