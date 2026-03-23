import '../../features/shared/services/escrow_status_history_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for EscrowStatusHistory

class GetEscrowStatusHistoryByIdUseCase {
  final EscrowStatusHistoryService _service;
  
  GetEscrowStatusHistoryByIdUseCase(this._service);
  
  Future<EscrowStatusHistory> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetEscrowStatusHistorysUseCase {
  final EscrowStatusHistoryService _service;
  
  GetEscrowStatusHistorysUseCase(this._service);
  
  Future<List<EscrowStatusHistory>> execute({
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

class CreateEscrowStatusHistoryUseCase {
  final EscrowStatusHistoryService _service;
  
  CreateEscrowStatusHistoryUseCase(this._service);
  
  Future<EscrowStatusHistory> execute(EscrowStatusHistory escrowStatusHistory) async {
    // Add validation logic here
    return await _service.create(escrowStatusHistory);
  }
}

class UpdateEscrowStatusHistoryUseCase {
  final EscrowStatusHistoryService _service;
  
  UpdateEscrowStatusHistoryUseCase(this._service);
  
  Future<EscrowStatusHistory> execute(String id, EscrowStatusHistory escrowStatusHistory) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, escrowStatusHistory);
  }
}

class DeleteEscrowStatusHistoryUseCase {
  final EscrowStatusHistoryService _service;
  
  DeleteEscrowStatusHistoryUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// EscrowStatusHistory Use Case Container
class EscrowStatusHistoryUseCases {
  final GetEscrowStatusHistoryByIdUseCase getById;
  final GetEscrowStatusHistorysUseCase getAll;
  final CreateEscrowStatusHistoryUseCase create;
  final UpdateEscrowStatusHistoryUseCase update;
  final DeleteEscrowStatusHistoryUseCase delete;
  
  EscrowStatusHistoryUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory EscrowStatusHistoryUseCases.create(EscrowStatusHistoryService service) {
    return EscrowStatusHistoryUseCases(
      getById: GetEscrowStatusHistoryByIdUseCase(service),
      getAll: GetEscrowStatusHistorysUseCase(service),
      create: CreateEscrowStatusHistoryUseCase(service),
      update: UpdateEscrowStatusHistoryUseCase(service),
      delete: DeleteEscrowStatusHistoryUseCase(service),
    );
  }
}
