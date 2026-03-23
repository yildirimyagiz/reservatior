import '../../features/shared/services/audit_log_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for AuditLog

class GetAuditLogByIdUseCase {
  final AuditLogService _service;
  
  GetAuditLogByIdUseCase(this._service);
  
  Future<AuditLog> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetAuditLogsUseCase {
  final AuditLogService _service;
  
  GetAuditLogsUseCase(this._service);
  
  Future<List<AuditLog>> execute({
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

class CreateAuditLogUseCase {
  final AuditLogService _service;
  
  CreateAuditLogUseCase(this._service);
  
  Future<AuditLog> execute(AuditLog auditLog) async {
    // Add validation logic here
    return await _service.create(auditLog);
  }
}

class UpdateAuditLogUseCase {
  final AuditLogService _service;
  
  UpdateAuditLogUseCase(this._service);
  
  Future<AuditLog> execute(String id, AuditLog auditLog) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, auditLog);
  }
}

class DeleteAuditLogUseCase {
  final AuditLogService _service;
  
  DeleteAuditLogUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// AuditLog Use Case Container
class AuditLogUseCases {
  final GetAuditLogByIdUseCase getById;
  final GetAuditLogsUseCase getAll;
  final CreateAuditLogUseCase create;
  final UpdateAuditLogUseCase update;
  final DeleteAuditLogUseCase delete;
  
  AuditLogUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory AuditLogUseCases.create(AuditLogService service) {
    return AuditLogUseCases(
      getById: GetAuditLogByIdUseCase(service),
      getAll: GetAuditLogsUseCase(service),
      create: CreateAuditLogUseCase(service),
      update: UpdateAuditLogUseCase(service),
      delete: DeleteAuditLogUseCase(service),
    );
  }
}
