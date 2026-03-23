import '../../features/shared/services/contract_version_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for ContractVersion

class GetContractVersionByIdUseCase {
  final ContractVersionService _service;
  
  GetContractVersionByIdUseCase(this._service);
  
  Future<ContractVersion> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetContractVersionsUseCase {
  final ContractVersionService _service;
  
  GetContractVersionsUseCase(this._service);
  
  Future<List<ContractVersion>> execute({
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

class CreateContractVersionUseCase {
  final ContractVersionService _service;
  
  CreateContractVersionUseCase(this._service);
  
  Future<ContractVersion> execute(ContractVersion contractVersion) async {
    // Add validation logic here
    return await _service.create(contractVersion);
  }
}

class UpdateContractVersionUseCase {
  final ContractVersionService _service;
  
  UpdateContractVersionUseCase(this._service);
  
  Future<ContractVersion> execute(String id, ContractVersion contractVersion) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, contractVersion);
  }
}

class DeleteContractVersionUseCase {
  final ContractVersionService _service;
  
  DeleteContractVersionUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// ContractVersion Use Case Container
class ContractVersionUseCases {
  final GetContractVersionByIdUseCase getById;
  final GetContractVersionsUseCase getAll;
  final CreateContractVersionUseCase create;
  final UpdateContractVersionUseCase update;
  final DeleteContractVersionUseCase delete;
  
  ContractVersionUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory ContractVersionUseCases.create(ContractVersionService service) {
    return ContractVersionUseCases(
      getById: GetContractVersionByIdUseCase(service),
      getAll: GetContractVersionsUseCase(service),
      create: CreateContractVersionUseCase(service),
      update: UpdateContractVersionUseCase(service),
      delete: DeleteContractVersionUseCase(service),
    );
  }
}
