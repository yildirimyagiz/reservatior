import '../../features/shared/services/escrow_dispute_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for EscrowDispute

class GetEscrowDisputeByIdUseCase {
  final EscrowDisputeService _service;
  
  GetEscrowDisputeByIdUseCase(this._service);
  
  Future<EscrowDispute> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetEscrowDisputesUseCase {
  final EscrowDisputeService _service;
  
  GetEscrowDisputesUseCase(this._service);
  
  Future<List<EscrowDispute>> execute({
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

class CreateEscrowDisputeUseCase {
  final EscrowDisputeService _service;
  
  CreateEscrowDisputeUseCase(this._service);
  
  Future<EscrowDispute> execute(EscrowDispute escrowDispute) async {
    // Add validation logic here
    return await _service.create(escrowDispute);
  }
}

class UpdateEscrowDisputeUseCase {
  final EscrowDisputeService _service;
  
  UpdateEscrowDisputeUseCase(this._service);
  
  Future<EscrowDispute> execute(String id, EscrowDispute escrowDispute) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, escrowDispute);
  }
}

class DeleteEscrowDisputeUseCase {
  final EscrowDisputeService _service;
  
  DeleteEscrowDisputeUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// EscrowDispute Use Case Container
class EscrowDisputeUseCases {
  final GetEscrowDisputeByIdUseCase getById;
  final GetEscrowDisputesUseCase getAll;
  final CreateEscrowDisputeUseCase create;
  final UpdateEscrowDisputeUseCase update;
  final DeleteEscrowDisputeUseCase delete;
  
  EscrowDisputeUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory EscrowDisputeUseCases.create(EscrowDisputeService service) {
    return EscrowDisputeUseCases(
      getById: GetEscrowDisputeByIdUseCase(service),
      getAll: GetEscrowDisputesUseCase(service),
      create: CreateEscrowDisputeUseCase(service),
      update: UpdateEscrowDisputeUseCase(service),
      delete: DeleteEscrowDisputeUseCase(service),
    );
  }
}
