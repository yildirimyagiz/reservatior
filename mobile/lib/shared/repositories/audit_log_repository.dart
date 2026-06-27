import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/audit_log_service.dart';

abstract class AuditLogRepository {
  Future<AuditLog> getById(String id);
  Future<List<AuditLog>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<AuditLog> create(AuditLog item);
  Future<AuditLog> update(String id, AuditLog item);
  Future<void> delete(String id);
}

class AuditLogRepositoryImpl implements AuditLogRepository {
  final AuditLogService _service;
  AuditLogRepositoryImpl(this._service);

  @override
  Future<AuditLog> getById(String id) => _service.getAuditLogById(id);

  @override
  Future<List<AuditLog>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getAuditLogs(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<AuditLog> create(AuditLog item) => _service.createAuditLog(item);

  @override
  Future<AuditLog> update(String id, AuditLog item) => _service.updateAuditLog(id, item);

  @override
  Future<void> delete(String id) => _service.deleteAuditLog(id);
}
