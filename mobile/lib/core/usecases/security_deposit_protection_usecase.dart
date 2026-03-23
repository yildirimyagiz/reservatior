import '../../features/shared/services/security_deposit_protection_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for SecurityDepositProtection

class GetSecurityDepositProtectionByIdUseCase {
  final SecurityDepositProtectionService _service;
  
  GetSecurityDepositProtectionByIdUseCase(this._service);
  
  Future<SecurityDepositProtection> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetSecurityDepositProtectionsUseCase {
  final SecurityDepositProtectionService _service;
  
  GetSecurityDepositProtectionsUseCase(this._service);
  
  Future<List<SecurityDepositProtection>> execute({
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

class CreateSecurityDepositProtectionUseCase {
  final SecurityDepositProtectionService _service;
  
  CreateSecurityDepositProtectionUseCase(this._service);
  
  Future<SecurityDepositProtection> execute(SecurityDepositProtection securityDepositProtection) async {
    // Add validation logic here
    return await _service.create(securityDepositProtection);
  }
}

class UpdateSecurityDepositProtectionUseCase {
  final SecurityDepositProtectionService _service;
  
  UpdateSecurityDepositProtectionUseCase(this._service);
  
  Future<SecurityDepositProtection> execute(String id, SecurityDepositProtection securityDepositProtection) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, securityDepositProtection);
  }
}

class DeleteSecurityDepositProtectionUseCase {
  final SecurityDepositProtectionService _service;
  
  DeleteSecurityDepositProtectionUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// SecurityDepositProtection Use Case Container
class SecurityDepositProtectionUseCases {
  final GetSecurityDepositProtectionByIdUseCase getById;
  final GetSecurityDepositProtectionsUseCase getAll;
  final CreateSecurityDepositProtectionUseCase create;
  final UpdateSecurityDepositProtectionUseCase update;
  final DeleteSecurityDepositProtectionUseCase delete;
  
  SecurityDepositProtectionUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory SecurityDepositProtectionUseCases.create(SecurityDepositProtectionService service) {
    return SecurityDepositProtectionUseCases(
      getById: GetSecurityDepositProtectionByIdUseCase(service),
      getAll: GetSecurityDepositProtectionsUseCase(service),
      create: CreateSecurityDepositProtectionUseCase(service),
      update: UpdateSecurityDepositProtectionUseCase(service),
      delete: DeleteSecurityDepositProtectionUseCase(service),
    );
  }
}
