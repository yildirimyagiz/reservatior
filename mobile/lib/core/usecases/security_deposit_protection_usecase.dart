import 'package:reservatior/shared/repositories/security_deposit_protection_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetSecurityDepositProtectionByIdUseCase {
  final SecurityDepositProtectionRepository _repository;
  GetSecurityDepositProtectionByIdUseCase(this._repository);
  Future<SecurityDepositProtection> execute(String id) => _repository.getById(id);
}

class GetSecurityDepositProtectionsUseCase {
  final SecurityDepositProtectionRepository _repository;
  GetSecurityDepositProtectionsUseCase(this._repository);
  Future<List<SecurityDepositProtection>> execute({
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

class CreateSecurityDepositProtectionUseCase {
  final SecurityDepositProtectionRepository _repository;
  CreateSecurityDepositProtectionUseCase(this._repository);
  Future<SecurityDepositProtection> execute(SecurityDepositProtection item) => _repository.create(item);
}

class UpdateSecurityDepositProtectionUseCase {
  final SecurityDepositProtectionRepository _repository;
  UpdateSecurityDepositProtectionUseCase(this._repository);
  Future<SecurityDepositProtection> execute(String id, SecurityDepositProtection item) => _repository.update(id, item);
}

class DeleteSecurityDepositProtectionUseCase {
  final SecurityDepositProtectionRepository _repository;
  DeleteSecurityDepositProtectionUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
