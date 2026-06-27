import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/neighborhood_service.dart';

abstract class NeighborhoodRepository {
  Future<Neighborhood> getById(String id);
  Future<List<Neighborhood>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<Neighborhood> create(Neighborhood item);
  Future<Neighborhood> update(String id, Neighborhood item);
  Future<void> delete(String id);
}

class NeighborhoodRepositoryImpl implements NeighborhoodRepository {
  final NeighborhoodService _service;
  NeighborhoodRepositoryImpl(this._service);

  @override
  Future<Neighborhood> getById(String id) => _service.getNeighborhoodById(id);

  @override
  Future<List<Neighborhood>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getNeighborhoods(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<Neighborhood> create(Neighborhood item) => _service.createNeighborhood(item);

  @override
  Future<Neighborhood> update(String id, Neighborhood item) => _service.updateNeighborhood(id, item);

  @override
  Future<void> delete(String id) => _service.deleteNeighborhood(id);
}
