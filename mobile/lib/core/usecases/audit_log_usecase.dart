import 'package:reservatior/shared/repositories/audit_log_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetAuditLogByIdUseCase {
  final AuditLogRepository _repository;
  GetAuditLogByIdUseCase(this._repository);
  Future<AuditLog> execute(String id) => _repository.getById(id);
}

class GetAuditLogsUseCase {
  final AuditLogRepository _repository;
  GetAuditLogsUseCase(this._repository);
  Future<List<AuditLog>> execute({
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

class CreateAuditLogUseCase {
  final AuditLogRepository _repository;
  CreateAuditLogUseCase(this._repository);
  Future<AuditLog> execute(AuditLog item) => _repository.create(item);
}

class UpdateAuditLogUseCase {
  final AuditLogRepository _repository;
  UpdateAuditLogUseCase(this._repository);
  Future<AuditLog> execute(String id, AuditLog item) => _repository.update(id, item);
}

class DeleteAuditLogUseCase {
  final AuditLogRepository _repository;
  DeleteAuditLogUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
