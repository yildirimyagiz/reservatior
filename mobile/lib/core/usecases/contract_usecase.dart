import '../../features/shared/services/contract_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for Contract

class GetContractByIdUseCase {
  final ContractService _service;
  
  GetContractByIdUseCase(this._service);
  
  Future<Contract> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetContractsUseCase {
  final ContractService _service;
  
  GetContractsUseCase(this._service);
  
  Future<List<Contract>> execute({
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

class CreateContractUseCase {
  final ContractService _service;
  
  CreateContractUseCase(this._service);
  
  Future<Contract> execute(Contract contract) async {
    // Add validation logic here
    return await _service.create(contract);
  }
}

class UpdateContractUseCase {
  final ContractService _service;
  
  UpdateContractUseCase(this._service);
  
  Future<Contract> execute(String id, Contract contract) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, contract);
  }
}

class DeleteContractUseCase {
  final ContractService _service;
  
  DeleteContractUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// Contract Use Case Container
class ContractUseCases {
  final GetContractByIdUseCase getById;
  final GetContractsUseCase getAll;
  final CreateContractUseCase create;
  final UpdateContractUseCase update;
  final DeleteContractUseCase delete;
  
  ContractUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory ContractUseCases.create(ContractService service) {
    return ContractUseCases(
      getById: GetContractByIdUseCase(service),
      getAll: GetContractsUseCase(service),
      create: CreateContractUseCase(service),
      update: UpdateContractUseCase(service),
      delete: DeleteContractUseCase(service),
    );
  }
}
