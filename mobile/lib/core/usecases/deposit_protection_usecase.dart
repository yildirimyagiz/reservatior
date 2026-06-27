import 'package:reservatior/shared/repositories/deposit_protection_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetDepositProtectionByIdUseCase {
  final DepositProtectionRepository _repository;
  GetDepositProtectionByIdUseCase(this._repository);
  Future<DepositProtection> execute(String id) => _repository.getById(id);
}

class GetDepositProtectionsUseCase {
  final DepositProtectionRepository _repository;
  GetDepositProtectionsUseCase(this._repository);
  Future<List<DepositProtection>> execute({
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

class CreateDepositProtectionUseCase {
  final DepositProtectionRepository _repository;
  CreateDepositProtectionUseCase(this._repository);
  Future<DepositProtection> execute(DepositProtection item) => _repository.create(item);
}

class UpdateDepositProtectionUseCase {
  final DepositProtectionRepository _repository;
  UpdateDepositProtectionUseCase(this._repository);
  Future<DepositProtection> execute(String id, DepositProtection item) => _repository.update(id, item);
}

class DeleteDepositProtectionUseCase {
  final DepositProtectionRepository _repository;
  DeleteDepositProtectionUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
