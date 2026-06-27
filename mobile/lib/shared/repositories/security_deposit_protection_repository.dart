import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/security_deposit_protection_service.dart';

abstract class SecurityDepositProtectionRepository {
  Future<SecurityDepositProtection> getById(String id);
  Future<List<SecurityDepositProtection>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<SecurityDepositProtection> create(SecurityDepositProtection item);
  Future<SecurityDepositProtection> update(String id, SecurityDepositProtection item);
  Future<void> delete(String id);
}

class SecurityDepositProtectionRepositoryImpl implements SecurityDepositProtectionRepository {
  final SecurityDepositProtectionService _service;
  SecurityDepositProtectionRepositoryImpl(this._service);

  @override
  Future<SecurityDepositProtection> getById(String id) => _service.getSecurityDepositProtectionById(id);

  @override
  Future<List<SecurityDepositProtection>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getSecurityDepositProtections(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<SecurityDepositProtection> create(SecurityDepositProtection item) => _service.createSecurityDepositProtection(item);

  @override
  Future<SecurityDepositProtection> update(String id, SecurityDepositProtection item) => _service.updateSecurityDepositProtection(id, item);

  @override
  Future<void> delete(String id) => _service.deleteSecurityDepositProtection(id);
}
