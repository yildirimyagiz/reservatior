import 'package:reservatior/shared/repositories/shared_amenity_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetSharedAmenityByIdUseCase {
  final SharedAmenityRepository _repository;
  GetSharedAmenityByIdUseCase(this._repository);
  Future<SharedAmenity> execute(String id) => _repository.getById(id);
}

class GetSharedAmenitysUseCase {
  final SharedAmenityRepository _repository;
  GetSharedAmenitysUseCase(this._repository);
  Future<List<SharedAmenity>> execute({
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

class CreateSharedAmenityUseCase {
  final SharedAmenityRepository _repository;
  CreateSharedAmenityUseCase(this._repository);
  Future<SharedAmenity> execute(SharedAmenity item) => _repository.create(item);
}

class UpdateSharedAmenityUseCase {
  final SharedAmenityRepository _repository;
  UpdateSharedAmenityUseCase(this._repository);
  Future<SharedAmenity> execute(String id, SharedAmenity item) => _repository.update(id, item);
}

class DeleteSharedAmenityUseCase {
  final SharedAmenityRepository _repository;
  DeleteSharedAmenityUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
