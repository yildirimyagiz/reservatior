import 'package:reservatior/shared/repositories/route_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetRouteByIdUseCase {
  final RouteRepository _repository;
  GetRouteByIdUseCase(this._repository);
  Future<Route> execute(String id) => _repository.getById(id);
}

class GetRoutesUseCase {
  final RouteRepository _repository;
  GetRoutesUseCase(this._repository);
  Future<List<Route>> execute({
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

class CreateRouteUseCase {
  final RouteRepository _repository;
  CreateRouteUseCase(this._repository);
  Future<Route> execute(Route item) => _repository.create(item);
}

class UpdateRouteUseCase {
  final RouteRepository _repository;
  UpdateRouteUseCase(this._repository);
  Future<Route> execute(String id, Route item) => _repository.update(id, item);
}

class DeleteRouteUseCase {
  final RouteRepository _repository;
  DeleteRouteUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
