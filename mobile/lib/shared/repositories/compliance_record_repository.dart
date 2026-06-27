import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/compliance_record_service.dart';

abstract class ComplianceRecordRepository {
  Future<ComplianceRecord> getById(String id);
  Future<List<ComplianceRecord>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<ComplianceRecord> create(ComplianceRecord item);
  Future<ComplianceRecord> update(String id, ComplianceRecord item);
  Future<void> delete(String id);
}

class ComplianceRecordRepositoryImpl implements ComplianceRecordRepository {
  final ComplianceRecordService _service;
  ComplianceRecordRepositoryImpl(this._service);

  @override
  Future<ComplianceRecord> getById(String id) => _service.getComplianceRecordById(id);

  @override
  Future<List<ComplianceRecord>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getComplianceRecords(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<ComplianceRecord> create(ComplianceRecord item) => _service.createComplianceRecord(item);

  @override
  Future<ComplianceRecord> update(String id, ComplianceRecord item) => _service.updateComplianceRecord(id, item);

  @override
  Future<void> delete(String id) => _service.deleteComplianceRecord(id);
}
