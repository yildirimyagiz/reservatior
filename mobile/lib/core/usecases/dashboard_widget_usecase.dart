import '../../features/shared/services/dashboard_widget_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for DashboardWidget

class GetDashboardWidgetByIdUseCase {
  final DashboardWidgetService _service;
  
  GetDashboardWidgetByIdUseCase(this._service);
  
  Future<DashboardWidget> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetDashboardWidgetsUseCase {
  final DashboardWidgetService _service;
  
  GetDashboardWidgetsUseCase(this._service);
  
  Future<List<DashboardWidget>> execute({
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

class CreateDashboardWidgetUseCase {
  final DashboardWidgetService _service;
  
  CreateDashboardWidgetUseCase(this._service);
  
  Future<DashboardWidget> execute(DashboardWidget dashboardWidget) async {
    // Add validation logic here
    return await _service.create(dashboardWidget);
  }
}

class UpdateDashboardWidgetUseCase {
  final DashboardWidgetService _service;
  
  UpdateDashboardWidgetUseCase(this._service);
  
  Future<DashboardWidget> execute(String id, DashboardWidget dashboardWidget) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, dashboardWidget);
  }
}

class DeleteDashboardWidgetUseCase {
  final DashboardWidgetService _service;
  
  DeleteDashboardWidgetUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// DashboardWidget Use Case Container
class DashboardWidgetUseCases {
  final GetDashboardWidgetByIdUseCase getById;
  final GetDashboardWidgetsUseCase getAll;
  final CreateDashboardWidgetUseCase create;
  final UpdateDashboardWidgetUseCase update;
  final DeleteDashboardWidgetUseCase delete;
  
  DashboardWidgetUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory DashboardWidgetUseCases.create(DashboardWidgetService service) {
    return DashboardWidgetUseCases(
      getById: GetDashboardWidgetByIdUseCase(service),
      getAll: GetDashboardWidgetsUseCase(service),
      create: CreateDashboardWidgetUseCase(service),
      update: UpdateDashboardWidgetUseCase(service),
      delete: DeleteDashboardWidgetUseCase(service),
    );
  }
}
