import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/account_service.dart';

abstract class AccountRepository {
  Future<Account> getById(String id);
  Future<List<Account>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<Account> create(Account item);
  Future<Account> update(String id, Account item);
  Future<void> delete(String id);
}

class AccountRepositoryImpl implements AccountRepository {
  final AccountService _service;
  AccountRepositoryImpl(this._service);

  @override
  Future<Account> getById(String id) => _service.getAccountById(id);

  @override
  Future<List<Account>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getAccounts(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<Account> create(Account item) => _service.createAccount(item);

  @override
  Future<Account> update(String id, Account item) => _service.updateAccount(id, item);

  @override
  Future<void> delete(String id) => _service.deleteAccount(id);
}
