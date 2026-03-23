import '../../features/shared/services/ambassador_contract_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for AmbassadorContract

class GetAmbassadorContractByIdUseCase {
  final AmbassadorContractService _service;
  
  GetAmbassadorContractByIdUseCase(this._service);
  
  Future<AmbassadorContract> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetAmbassadorContractsUseCase {
  final AmbassadorContractService _service;
  
  GetAmbassadorContractsUseCase(this._service);
  
  Future<List<AmbassadorContract>> execute({
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

class CreateAmbassadorContractUseCase {
  final AmbassadorContractService _service;
  
  CreateAmbassadorContractUseCase(this._service);
  
  Future<AmbassadorContract> execute(AmbassadorContract ambassadorContract) async {
    // Add validation logic here
    return await _service.create(ambassadorContract);
  }
}

class UpdateAmbassadorContractUseCase {
  final AmbassadorContractService _service;
  
  UpdateAmbassadorContractUseCase(this._service);
  
  Future<AmbassadorContract> execute(String id, AmbassadorContract ambassadorContract) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, ambassadorContract);
  }
}

class DeleteAmbassadorContractUseCase {
  final AmbassadorContractService _service;
  
  DeleteAmbassadorContractUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// AmbassadorContract Use Case Container
class AmbassadorContractUseCases {
  final GetAmbassadorContractByIdUseCase getById;
  final GetAmbassadorContractsUseCase getAll;
  final CreateAmbassadorContractUseCase create;
  final UpdateAmbassadorContractUseCase update;
  final DeleteAmbassadorContractUseCase delete;
  
  AmbassadorContractUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory AmbassadorContractUseCases.create(AmbassadorContractService service) {
    return AmbassadorContractUseCases(
      getById: GetAmbassadorContractByIdUseCase(service),
      getAll: GetAmbassadorContractsUseCase(service),
      create: CreateAmbassadorContractUseCase(service),
      update: UpdateAmbassadorContractUseCase(service),
      delete: DeleteAmbassadorContractUseCase(service),
    );
  }
}
