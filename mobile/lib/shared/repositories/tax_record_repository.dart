import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/tax_record_service.dart';

abstract class TaxRecordRepository {
  Future<TaxRecord> getById(String id);
  Future<List<TaxRecord>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<TaxRecord> create(TaxRecord item);
  Future<TaxRecord> update(String id, TaxRecord item);
  Future<void> delete(String id);
}

class TaxRecordRepositoryImpl implements TaxRecordRepository {
  final TaxRecordService _service;
  TaxRecordRepositoryImpl(this._service);

  @override
  Future<TaxRecord> getById(String id) => _service.getTaxRecordById(id);

  @override
  Future<List<TaxRecord>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getTaxRecords(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<TaxRecord> create(TaxRecord item) => _service.createTaxRecord(item);

  @override
  Future<TaxRecord> update(String id, TaxRecord item) => _service.updateTaxRecord(id, item);

  @override
  Future<void> delete(String id) => _service.deleteTaxRecord(id);
}
