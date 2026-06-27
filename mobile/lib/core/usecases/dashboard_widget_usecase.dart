import 'package:reservatior/shared/repositories/dashboard_widget_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetDashboardWidgetByIdUseCase {
  final DashboardWidgetRepository _repository;
  GetDashboardWidgetByIdUseCase(this._repository);
  Future<DashboardWidget> execute(String id) => _repository.getById(id);
}

class GetDashboardWidgetsUseCase {
  final DashboardWidgetRepository _repository;
  GetDashboardWidgetsUseCase(this._repository);
  Future<List<DashboardWidget>> execute({
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

class CreateDashboardWidgetUseCase {
  final DashboardWidgetRepository _repository;
  CreateDashboardWidgetUseCase(this._repository);
  Future<DashboardWidget> execute(DashboardWidget item) => _repository.create(item);
}

class UpdateDashboardWidgetUseCase {
  final DashboardWidgetRepository _repository;
  UpdateDashboardWidgetUseCase(this._repository);
  Future<DashboardWidget> execute(String id, DashboardWidget item) => _repository.update(id, item);
}

class DeleteDashboardWidgetUseCase {
  final DashboardWidgetRepository _repository;
  DeleteDashboardWidgetUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
