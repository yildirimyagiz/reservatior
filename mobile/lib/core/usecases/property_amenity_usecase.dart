import 'package:reservatior/shared/repositories/property_amenity_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetPropertyAmenityByIdUseCase {
  final PropertyAmenityRepository _repository;
  GetPropertyAmenityByIdUseCase(this._repository);
  Future<PropertyAmenity> execute(String id) => _repository.getById(id);
}

class GetPropertyAmenitysUseCase {
  final PropertyAmenityRepository _repository;
  GetPropertyAmenitysUseCase(this._repository);
  Future<List<PropertyAmenity>> execute({
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

class CreatePropertyAmenityUseCase {
  final PropertyAmenityRepository _repository;
  CreatePropertyAmenityUseCase(this._repository);
  Future<PropertyAmenity> execute(PropertyAmenity item) => _repository.create(item);
}

class UpdatePropertyAmenityUseCase {
  final PropertyAmenityRepository _repository;
  UpdatePropertyAmenityUseCase(this._repository);
  Future<PropertyAmenity> execute(String id, PropertyAmenity item) => _repository.update(id, item);
}

class DeletePropertyAmenityUseCase {
  final PropertyAmenityRepository _repository;
  DeletePropertyAmenityUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
