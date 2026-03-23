import '../../features/shared/services/deposit_protection_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for DepositProtection

class GetDepositProtectionByIdUseCase {
  final DepositProtectionService _service;
  
  GetDepositProtectionByIdUseCase(this._service);
  
  Future<DepositProtection> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetDepositProtectionsUseCase {
  final DepositProtectionService _service;
  
  GetDepositProtectionsUseCase(this._service);
  
  Future<List<DepositProtection>> execute({
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

class CreateDepositProtectionUseCase {
  final DepositProtectionService _service;
  
  CreateDepositProtectionUseCase(this._service);
  
  Future<DepositProtection> execute(DepositProtection depositProtection) async {
    // Add validation logic here
    return await _service.create(depositProtection);
  }
}

class UpdateDepositProtectionUseCase {
  final DepositProtectionService _service;
  
  UpdateDepositProtectionUseCase(this._service);
  
  Future<DepositProtection> execute(String id, DepositProtection depositProtection) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, depositProtection);
  }
}

class DeleteDepositProtectionUseCase {
  final DepositProtectionService _service;
  
  DeleteDepositProtectionUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// DepositProtection Use Case Container
class DepositProtectionUseCases {
  final GetDepositProtectionByIdUseCase getById;
  final GetDepositProtectionsUseCase getAll;
  final CreateDepositProtectionUseCase create;
  final UpdateDepositProtectionUseCase update;
  final DeleteDepositProtectionUseCase delete;
  
  DepositProtectionUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory DepositProtectionUseCases.create(DepositProtectionService service) {
    return DepositProtectionUseCases(
      getById: GetDepositProtectionByIdUseCase(service),
      getAll: GetDepositProtectionsUseCase(service),
      create: CreateDepositProtectionUseCase(service),
      update: UpdateDepositProtectionUseCase(service),
      delete: DeleteDepositProtectionUseCase(service),
    );
  }
}
