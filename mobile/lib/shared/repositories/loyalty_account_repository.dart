import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/loyalty_account_service.dart';

abstract class LoyaltyAccountRepository {
  Future<LoyaltyAccount> getById(String id);
  Future<List<LoyaltyAccount>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<LoyaltyAccount> create(LoyaltyAccount item);
  Future<LoyaltyAccount> update(String id, LoyaltyAccount item);
  Future<void> delete(String id);
}

class LoyaltyAccountRepositoryImpl implements LoyaltyAccountRepository {
  final LoyaltyAccountService _service;
  LoyaltyAccountRepositoryImpl(this._service);

  @override
  Future<LoyaltyAccount> getById(String id) => _service.getLoyaltyAccountById(id);

  @override
  Future<List<LoyaltyAccount>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getLoyaltyAccounts(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<LoyaltyAccount> create(LoyaltyAccount item) => _service.createLoyaltyAccount(item);

  @override
  Future<LoyaltyAccount> update(String id, LoyaltyAccount item) => _service.updateLoyaltyAccount(id, item);

  @override
  Future<void> delete(String id) => _service.deleteLoyaltyAccount(id);
}
