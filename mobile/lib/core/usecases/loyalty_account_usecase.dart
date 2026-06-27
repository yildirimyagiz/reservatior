import 'package:reservatior/shared/repositories/loyalty_account_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetLoyaltyAccountByIdUseCase {
  final LoyaltyAccountRepository _repository;
  GetLoyaltyAccountByIdUseCase(this._repository);
  Future<LoyaltyAccount> execute(String id) => _repository.getById(id);
}

class GetLoyaltyAccountsUseCase {
  final LoyaltyAccountRepository _repository;
  GetLoyaltyAccountsUseCase(this._repository);
  Future<List<LoyaltyAccount>> execute({
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

class CreateLoyaltyAccountUseCase {
  final LoyaltyAccountRepository _repository;
  CreateLoyaltyAccountUseCase(this._repository);
  Future<LoyaltyAccount> execute(LoyaltyAccount item) => _repository.create(item);
}

class UpdateLoyaltyAccountUseCase {
  final LoyaltyAccountRepository _repository;
  UpdateLoyaltyAccountUseCase(this._repository);
  Future<LoyaltyAccount> execute(String id, LoyaltyAccount item) => _repository.update(id, item);
}

class DeleteLoyaltyAccountUseCase {
  final LoyaltyAccountRepository _repository;
  DeleteLoyaltyAccountUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
