import '../../features/shared/services/route_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for Route

class GetRouteByIdUseCase {
  final RouteService _service;
  
  GetRouteByIdUseCase(this._service);
  
  Future<Route> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetRoutesUseCase {
  final RouteService _service;
  
  GetRoutesUseCase(this._service);
  
  Future<List<Route>> execute({
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

class CreateRouteUseCase {
  final RouteService _service;
  
  CreateRouteUseCase(this._service);
  
  Future<Route> execute(Route route) async {
    // Add validation logic here
    return await _service.create(route);
  }
}

class UpdateRouteUseCase {
  final RouteService _service;
  
  UpdateRouteUseCase(this._service);
  
  Future<Route> execute(String id, Route route) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, route);
  }
}

class DeleteRouteUseCase {
  final RouteService _service;
  
  DeleteRouteUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// Route Use Case Container
class RouteUseCases {
  final GetRouteByIdUseCase getById;
  final GetRoutesUseCase getAll;
  final CreateRouteUseCase create;
  final UpdateRouteUseCase update;
  final DeleteRouteUseCase delete;
  
  RouteUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory RouteUseCases.create(RouteService service) {
    return RouteUseCases(
      getById: GetRouteByIdUseCase(service),
      getAll: GetRoutesUseCase(service),
      create: CreateRouteUseCase(service),
      update: UpdateRouteUseCase(service),
      delete: DeleteRouteUseCase(service),
    );
  }
}
