import 'package:reservatior/shared/repositories/location_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetLocationByIdUseCase {
  final LocationRepository _repository;
  GetLocationByIdUseCase(this._repository);
  Future<Location> execute(String id) => _repository.getById(id);
}

class GetLocationsUseCase {
  final LocationRepository _repository;
  GetLocationsUseCase(this._repository);
  Future<List<Location>> execute({
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

class CreateLocationUseCase {
  final LocationRepository _repository;
  CreateLocationUseCase(this._repository);
  Future<Location> execute(Location item) => _repository.create(item);
}

class UpdateLocationUseCase {
  final LocationRepository _repository;
  UpdateLocationUseCase(this._repository);
  Future<Location> execute(String id, Location item) => _repository.update(id, item);
}

class DeleteLocationUseCase {
  final LocationRepository _repository;
  DeleteLocationUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
