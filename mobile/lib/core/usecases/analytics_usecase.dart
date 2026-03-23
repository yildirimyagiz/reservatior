import '../../features/shared/services/analytics_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for Analytics

class GetAnalyticsByIdUseCase {
  final AnalyticsService _service;
  
  GetAnalyticsByIdUseCase(this._service);
  
  Future<Analytics> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetAnalyticssUseCase {
  final AnalyticsService _service;
  
  GetAnalyticssUseCase(this._service);
  
  Future<List<Analytics>> execute({
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

class CreateAnalyticsUseCase {
  final AnalyticsService _service;
  
  CreateAnalyticsUseCase(this._service);
  
  Future<Analytics> execute(Analytics analytics) async {
    // Add validation logic here
    return await _service.create(analytics);
  }
}

class UpdateAnalyticsUseCase {
  final AnalyticsService _service;
  
  UpdateAnalyticsUseCase(this._service);
  
  Future<Analytics> execute(String id, Analytics analytics) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, analytics);
  }
}

class DeleteAnalyticsUseCase {
  final AnalyticsService _service;
  
  DeleteAnalyticsUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// Analytics Use Case Container
class AnalyticsUseCases {
  final GetAnalyticsByIdUseCase getById;
  final GetAnalyticssUseCase getAll;
  final CreateAnalyticsUseCase create;
  final UpdateAnalyticsUseCase update;
  final DeleteAnalyticsUseCase delete;
  
  AnalyticsUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory AnalyticsUseCases.create(AnalyticsService service) {
    return AnalyticsUseCases(
      getById: GetAnalyticsByIdUseCase(service),
      getAll: GetAnalyticssUseCase(service),
      create: CreateAnalyticsUseCase(service),
      update: UpdateAnalyticsUseCase(service),
      delete: DeleteAnalyticsUseCase(service),
    );
  }
}
