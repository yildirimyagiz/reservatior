import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/map_layer_service.dart';

abstract class MapLayerRepository {
  Future<MapLayer> getById(String id);
  Future<List<MapLayer>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<MapLayer> create(MapLayer item);
  Future<MapLayer> update(String id, MapLayer item);
  Future<void> delete(String id);
}

class MapLayerRepositoryImpl implements MapLayerRepository {
  final MapLayerService _service;
  MapLayerRepositoryImpl(this._service);

  @override
  Future<MapLayer> getById(String id) => _service.getMapLayerById(id);

  @override
  Future<List<MapLayer>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getMapLayers(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<MapLayer> create(MapLayer item) => _service.createMapLayer(item);

  @override
  Future<MapLayer> update(String id, MapLayer item) => _service.updateMapLayer(id, item);

  @override
  Future<void> delete(String id) => _service.deleteMapLayer(id);
}
