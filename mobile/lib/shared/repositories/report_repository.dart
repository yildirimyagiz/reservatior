import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/report_service.dart';

abstract class ReportRepository {
  Future<Report> getById(String id);
  Future<List<Report>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<Report> create(Report item);
  Future<Report> update(String id, Report item);
  Future<void> delete(String id);
}

class ReportRepositoryImpl implements ReportRepository {
  final ReportService _service;
  ReportRepositoryImpl(this._service);

  @override
  Future<Report> getById(String id) => _service.getReportById(id);

  @override
  Future<List<Report>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getReports(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<Report> create(Report item) => _service.createReport(item);

  @override
  Future<Report> update(String id, Report item) => _service.updateReport(id, item);

  @override
  Future<void> delete(String id) => _service.deleteReport(id);
}
