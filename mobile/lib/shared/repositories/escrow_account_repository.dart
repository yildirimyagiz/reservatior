import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/escrow_account_service.dart';

abstract class EscrowAccountRepository {
  Future<EscrowAccount> getById(String id);
  Future<List<EscrowAccount>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<EscrowAccount> create(EscrowAccount item);
  Future<EscrowAccount> update(String id, EscrowAccount item);
  Future<void> delete(String id);
}

class EscrowAccountRepositoryImpl implements EscrowAccountRepository {
  final EscrowAccountService _service;
  EscrowAccountRepositoryImpl(this._service);

  @override
  Future<EscrowAccount> getById(String id) => _service.getEscrowAccountById(id);

  @override
  Future<List<EscrowAccount>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getEscrowAccounts(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<EscrowAccount> create(EscrowAccount item) => _service.createEscrowAccount(item);

  @override
  Future<EscrowAccount> update(String id, EscrowAccount item) => _service.updateEscrowAccount(id, item);

  @override
  Future<void> delete(String id) => _service.deleteEscrowAccount(id);
}
