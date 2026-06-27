import 'package:reservatior/shared/repositories/map_layer_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetMapLayerByIdUseCase {
  final MapLayerRepository _repository;
  GetMapLayerByIdUseCase(this._repository);
  Future<MapLayer> execute(String id) => _repository.getById(id);
}

class GetMapLayersUseCase {
  final MapLayerRepository _repository;
  GetMapLayersUseCase(this._repository);
  Future<List<MapLayer>> execute({
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

class CreateMapLayerUseCase {
  final MapLayerRepository _repository;
  CreateMapLayerUseCase(this._repository);
  Future<MapLayer> execute(MapLayer item) => _repository.create(item);
}

class UpdateMapLayerUseCase {
  final MapLayerRepository _repository;
  UpdateMapLayerUseCase(this._repository);
  Future<MapLayer> execute(String id, MapLayer item) => _repository.update(id, item);
}

class DeleteMapLayerUseCase {
  final MapLayerRepository _repository;
  DeleteMapLayerUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
