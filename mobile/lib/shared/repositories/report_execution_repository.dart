import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/report_execution_service.dart';

abstract class ReportExecutionRepository {
  Future<ReportExecution> getById(String id);
  Future<List<ReportExecution>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<ReportExecution> create(ReportExecution item);
  Future<ReportExecution> update(String id, ReportExecution item);
  Future<void> delete(String id);
}

class ReportExecutionRepositoryImpl implements ReportExecutionRepository {
  final ReportExecutionService _service;
  ReportExecutionRepositoryImpl(this._service);

  @override
  Future<ReportExecution> getById(String id) => _service.getReportExecutionById(id);

  @override
  Future<List<ReportExecution>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getReportExecutions(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<ReportExecution> create(ReportExecution item) => _service.createReportExecution(item);

  @override
  Future<ReportExecution> update(String id, ReportExecution item) => _service.updateReportExecution(id, item);

  @override
  Future<void> delete(String id) => _service.deleteReportExecution(id);
}
