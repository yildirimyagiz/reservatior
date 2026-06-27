import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/ledger_entry_service.dart';

abstract class LedgerEntryRepository {
  Future<LedgerEntry> getById(String id);
  Future<List<LedgerEntry>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<LedgerEntry> create(LedgerEntry item);
  Future<LedgerEntry> update(String id, LedgerEntry item);
  Future<void> delete(String id);
}

class LedgerEntryRepositoryImpl implements LedgerEntryRepository {
  final LedgerEntryService _service;
  LedgerEntryRepositoryImpl(this._service);

  @override
  Future<LedgerEntry> getById(String id) => _service.getLedgerEntryById(id);

  @override
  Future<List<LedgerEntry>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getLedgerEntries(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<LedgerEntry> create(LedgerEntry item) => _service.createLedgerEntry(item);

  @override
  Future<LedgerEntry> update(String id, LedgerEntry item) => _service.updateLedgerEntry(id, item);

  @override
  Future<void> delete(String id) => _service.deleteLedgerEntry(id);
}
