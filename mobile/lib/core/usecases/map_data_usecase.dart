import 'package:reservatior/shared/repositories/map_data_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetMapDataByIdUseCase {
  final MapDataRepository _repository;
  GetMapDataByIdUseCase(this._repository);
  Future<MapData> execute(String id) => _repository.getById(id);
}

class GetMapDatasUseCase {
  final MapDataRepository _repository;
  GetMapDatasUseCase(this._repository);
  Future<List<MapData>> execute({
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

class CreateMapDataUseCase {
  final MapDataRepository _repository;
  CreateMapDataUseCase(this._repository);
  Future<MapData> execute(MapData item) => _repository.create(item);
}

class UpdateMapDataUseCase {
  final MapDataRepository _repository;
  UpdateMapDataUseCase(this._repository);
  Future<MapData> execute(String id, MapData item) => _repository.update(id, item);
}

class DeleteMapDataUseCase {
  final MapDataRepository _repository;
  DeleteMapDataUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
