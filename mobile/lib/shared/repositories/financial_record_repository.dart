import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/financial_record_service.dart';

abstract class FinancialRecordRepository {
  Future<FinancialRecord> getById(String id);
  Future<List<FinancialRecord>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<FinancialRecord> create(FinancialRecord item);
  Future<FinancialRecord> update(String id, FinancialRecord item);
  Future<void> delete(String id);
}

class FinancialRecordRepositoryImpl implements FinancialRecordRepository {
  final FinancialRecordService _service;
  FinancialRecordRepositoryImpl(this._service);

  @override
  Future<FinancialRecord> getById(String id) => _service.getFinancialRecordById(id);

  @override
  Future<List<FinancialRecord>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getFinancialRecords(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<FinancialRecord> create(FinancialRecord item) => _service.createFinancialRecord(item);

  @override
  Future<FinancialRecord> update(String id, FinancialRecord item) => _service.updateFinancialRecord(id, item);

  @override
  Future<void> delete(String id) => _service.deleteFinancialRecord(id);
}
