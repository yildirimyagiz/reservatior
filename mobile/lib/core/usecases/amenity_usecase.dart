import 'package:reservatior/shared/repositories/amenity_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetAmenityByIdUseCase {
  final AmenityRepository _repository;
  GetAmenityByIdUseCase(this._repository);
  Future<Amenity> execute(String id) => _repository.getById(id);
}

class GetAmenitysUseCase {
  final AmenityRepository _repository;
  GetAmenitysUseCase(this._repository);
  Future<List<Amenity>> execute({
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

class CreateAmenityUseCase {
  final AmenityRepository _repository;
  CreateAmenityUseCase(this._repository);
  Future<Amenity> execute(Amenity item) => _repository.create(item);
}

class UpdateAmenityUseCase {
  final AmenityRepository _repository;
  UpdateAmenityUseCase(this._repository);
  Future<Amenity> execute(String id, Amenity item) => _repository.update(id, item);
}

class DeleteAmenityUseCase {
  final AmenityRepository _repository;
  DeleteAmenityUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
