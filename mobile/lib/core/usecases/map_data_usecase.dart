import '../../features/shared/services/map_data_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for MapData

class GetMapDataByIdUseCase {
  final MapDataService _service;
  
  GetMapDataByIdUseCase(this._service);
  
  Future<MapData> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetMapDatasUseCase {
  final MapDataService _service;
  
  GetMapDatasUseCase(this._service);
  
  Future<List<MapData>> execute({
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

class CreateMapDataUseCase {
  final MapDataService _service;
  
  CreateMapDataUseCase(this._service);
  
  Future<MapData> execute(MapData mapData) async {
    // Add validation logic here
    return await _service.create(mapData);
  }
}

class UpdateMapDataUseCase {
  final MapDataService _service;
  
  UpdateMapDataUseCase(this._service);
  
  Future<MapData> execute(String id, MapData mapData) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, mapData);
  }
}

class DeleteMapDataUseCase {
  final MapDataService _service;
  
  DeleteMapDataUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// MapData Use Case Container
class MapDataUseCases {
  final GetMapDataByIdUseCase getById;
  final GetMapDatasUseCase getAll;
  final CreateMapDataUseCase create;
  final UpdateMapDataUseCase update;
  final DeleteMapDataUseCase delete;
  
  MapDataUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory MapDataUseCases.create(MapDataService service) {
    return MapDataUseCases(
      getById: GetMapDataByIdUseCase(service),
      getAll: GetMapDatasUseCase(service),
      create: CreateMapDataUseCase(service),
      update: UpdateMapDataUseCase(service),
      delete: DeleteMapDataUseCase(service),
    );
  }
}
