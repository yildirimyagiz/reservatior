import 'package:reservatior/shared/repositories/ledger_entry_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetLedgerEntryByIdUseCase {
  final LedgerEntryRepository _repository;
  GetLedgerEntryByIdUseCase(this._repository);
  Future<LedgerEntry> execute(String id) => _repository.getById(id);
}

class GetLedgerEntrysUseCase {
  final LedgerEntryRepository _repository;
  GetLedgerEntrysUseCase(this._repository);
  Future<List<LedgerEntry>> execute({
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

class CreateLedgerEntryUseCase {
  final LedgerEntryRepository _repository;
  CreateLedgerEntryUseCase(this._repository);
  Future<LedgerEntry> execute(LedgerEntry item) => _repository.create(item);
}

class UpdateLedgerEntryUseCase {
  final LedgerEntryRepository _repository;
  UpdateLedgerEntryUseCase(this._repository);
  Future<LedgerEntry> execute(String id, LedgerEntry item) => _repository.update(id, item);
}

class DeleteLedgerEntryUseCase {
  final LedgerEntryRepository _repository;
  DeleteLedgerEntryUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
