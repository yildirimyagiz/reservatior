import '../../features/shared/services/ledger_entry_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for LedgerEntry

class GetLedgerEntryByIdUseCase {
  final LedgerEntryService _service;
  
  GetLedgerEntryByIdUseCase(this._service);
  
  Future<LedgerEntry> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetLedgerEntrysUseCase {
  final LedgerEntryService _service;
  
  GetLedgerEntrysUseCase(this._service);
  
  Future<List<LedgerEntry>> execute({
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

class CreateLedgerEntryUseCase {
  final LedgerEntryService _service;
  
  CreateLedgerEntryUseCase(this._service);
  
  Future<LedgerEntry> execute(LedgerEntry ledgerEntry) async {
    // Add validation logic here
    return await _service.create(ledgerEntry);
  }
}

class UpdateLedgerEntryUseCase {
  final LedgerEntryService _service;
  
  UpdateLedgerEntryUseCase(this._service);
  
  Future<LedgerEntry> execute(String id, LedgerEntry ledgerEntry) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, ledgerEntry);
  }
}

class DeleteLedgerEntryUseCase {
  final LedgerEntryService _service;
  
  DeleteLedgerEntryUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// LedgerEntry Use Case Container
class LedgerEntryUseCases {
  final GetLedgerEntryByIdUseCase getById;
  final GetLedgerEntrysUseCase getAll;
  final CreateLedgerEntryUseCase create;
  final UpdateLedgerEntryUseCase update;
  final DeleteLedgerEntryUseCase delete;
  
  LedgerEntryUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory LedgerEntryUseCases.create(LedgerEntryService service) {
    return LedgerEntryUseCases(
      getById: GetLedgerEntryByIdUseCase(service),
      getAll: GetLedgerEntrysUseCase(service),
      create: CreateLedgerEntryUseCase(service),
      update: UpdateLedgerEntryUseCase(service),
      delete: DeleteLedgerEntryUseCase(service),
    );
  }
}
