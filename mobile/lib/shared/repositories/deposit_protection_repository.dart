import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/deposit_protection_service.dart';

abstract class DepositProtectionRepository {
  Future<DepositProtection> getById(String id);
  Future<List<DepositProtection>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<DepositProtection> create(DepositProtection item);
  Future<DepositProtection> update(String id, DepositProtection item);
  Future<void> delete(String id);
}

class DepositProtectionRepositoryImpl implements DepositProtectionRepository {
  final DepositProtectionService _service;
  DepositProtectionRepositoryImpl(this._service);

  @override
  Future<DepositProtection> getById(String id) => _service.getDepositProtectionById(id);

  @override
  Future<List<DepositProtection>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getDepositProtections(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<DepositProtection> create(DepositProtection item) => _service.createDepositProtection(item);

  @override
  Future<DepositProtection> update(String id, DepositProtection item) => _service.updateDepositProtection(id, item);

  @override
  Future<void> delete(String id) => _service.deleteDepositProtection(id);
}
