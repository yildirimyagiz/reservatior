import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/route_service.dart';

abstract class RouteRepository {
  Future<Route> getById(String id);
  Future<List<Route>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<Route> create(Route item);
  Future<Route> update(String id, Route item);
  Future<void> delete(String id);
}

class RouteRepositoryImpl implements RouteRepository {
  final RouteService _service;
  RouteRepositoryImpl(this._service);

  @override
  Future<Route> getById(String id) => _service.getRouteById(id);

  @override
  Future<List<Route>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getRoutes(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<Route> create(Route item) => _service.createRoute(item);

  @override
  Future<Route> update(String id, Route item) => _service.updateRoute(id, item);

  @override
  Future<void> delete(String id) => _service.deleteRoute(id);
}
