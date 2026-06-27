import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/map_data_service.dart';

abstract class MapDataRepository {
  Future<MapData> getById(String id);
  Future<List<MapData>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<MapData> create(MapData item);
  Future<MapData> update(String id, MapData item);
  Future<void> delete(String id);
}

class MapDataRepositoryImpl implements MapDataRepository {
  final MapDataService _service;
  MapDataRepositoryImpl(this._service);

  @override
  Future<MapData> getById(String id) => _service.getMapDataById(id);

  @override
  Future<List<MapData>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getMapDatas(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<MapData> create(MapData item) => _service.createMapData(item);

  @override
  Future<MapData> update(String id, MapData item) => _service.updateMapData(id, item);

  @override
  Future<void> delete(String id) => _service.deleteMapData(id);
}
