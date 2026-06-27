import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/dashboard_widget_service.dart';

abstract class DashboardWidgetRepository {
  Future<DashboardWidget> getById(String id);
  Future<List<DashboardWidget>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<DashboardWidget> create(DashboardWidget item);
  Future<DashboardWidget> update(String id, DashboardWidget item);
  Future<void> delete(String id);
}

class DashboardWidgetRepositoryImpl implements DashboardWidgetRepository {
  final DashboardWidgetService _service;
  DashboardWidgetRepositoryImpl(this._service);

  @override
  Future<DashboardWidget> getById(String id) => _service.getDashboardWidgetById(id);

  @override
  Future<List<DashboardWidget>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getDashboardWidgets(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<DashboardWidget> create(DashboardWidget item) => _service.createDashboardWidget(item);

  @override
  Future<DashboardWidget> update(String id, DashboardWidget item) => _service.updateDashboardWidget(id, item);

  @override
  Future<void> delete(String id) => _service.deleteDashboardWidget(id);
}
