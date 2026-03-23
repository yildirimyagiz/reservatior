import '../../features/shared/services/loyalty_account_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for LoyaltyAccount

class GetLoyaltyAccountByIdUseCase {
  final LoyaltyAccountService _service;
  
  GetLoyaltyAccountByIdUseCase(this._service);
  
  Future<LoyaltyAccount> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetLoyaltyAccountsUseCase {
  final LoyaltyAccountService _service;
  
  GetLoyaltyAccountsUseCase(this._service);
  
  Future<List<LoyaltyAccount>> execute({
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

class CreateLoyaltyAccountUseCase {
  final LoyaltyAccountService _service;
  
  CreateLoyaltyAccountUseCase(this._service);
  
  Future<LoyaltyAccount> execute(LoyaltyAccount loyaltyAccount) async {
    // Add validation logic here
    return await _service.create(loyaltyAccount);
  }
}

class UpdateLoyaltyAccountUseCase {
  final LoyaltyAccountService _service;
  
  UpdateLoyaltyAccountUseCase(this._service);
  
  Future<LoyaltyAccount> execute(String id, LoyaltyAccount loyaltyAccount) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, loyaltyAccount);
  }
}

class DeleteLoyaltyAccountUseCase {
  final LoyaltyAccountService _service;
  
  DeleteLoyaltyAccountUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// LoyaltyAccount Use Case Container
class LoyaltyAccountUseCases {
  final GetLoyaltyAccountByIdUseCase getById;
  final GetLoyaltyAccountsUseCase getAll;
  final CreateLoyaltyAccountUseCase create;
  final UpdateLoyaltyAccountUseCase update;
  final DeleteLoyaltyAccountUseCase delete;
  
  LoyaltyAccountUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory LoyaltyAccountUseCases.create(LoyaltyAccountService service) {
    return LoyaltyAccountUseCases(
      getById: GetLoyaltyAccountByIdUseCase(service),
      getAll: GetLoyaltyAccountsUseCase(service),
      create: CreateLoyaltyAccountUseCase(service),
      update: UpdateLoyaltyAccountUseCase(service),
      delete: DeleteLoyaltyAccountUseCase(service),
    );
  }
}
