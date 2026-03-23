import '../../features/shared/services/map_layer_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for MapLayer

class GetMapLayerByIdUseCase {
  final MapLayerService _service;
  
  GetMapLayerByIdUseCase(this._service);
  
  Future<MapLayer> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetMapLayersUseCase {
  final MapLayerService _service;
  
  GetMapLayersUseCase(this._service);
  
  Future<List<MapLayer>> execute({
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

class CreateMapLayerUseCase {
  final MapLayerService _service;
  
  CreateMapLayerUseCase(this._service);
  
  Future<MapLayer> execute(MapLayer mapLayer) async {
    // Add validation logic here
    return await _service.create(mapLayer);
  }
}

class UpdateMapLayerUseCase {
  final MapLayerService _service;
  
  UpdateMapLayerUseCase(this._service);
  
  Future<MapLayer> execute(String id, MapLayer mapLayer) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, mapLayer);
  }
}

class DeleteMapLayerUseCase {
  final MapLayerService _service;
  
  DeleteMapLayerUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// MapLayer Use Case Container
class MapLayerUseCases {
  final GetMapLayerByIdUseCase getById;
  final GetMapLayersUseCase getAll;
  final CreateMapLayerUseCase create;
  final UpdateMapLayerUseCase update;
  final DeleteMapLayerUseCase delete;
  
  MapLayerUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory MapLayerUseCases.create(MapLayerService service) {
    return MapLayerUseCases(
      getById: GetMapLayerByIdUseCase(service),
      getAll: GetMapLayersUseCase(service),
      create: CreateMapLayerUseCase(service),
      update: UpdateMapLayerUseCase(service),
      delete: DeleteMapLayerUseCase(service),
    );
  }
}
