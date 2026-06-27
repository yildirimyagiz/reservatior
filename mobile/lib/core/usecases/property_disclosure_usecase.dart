import 'package:reservatior/shared/repositories/property_disclosure_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetPropertyDisclosureByIdUseCase {
  final PropertyDisclosureRepository _repository;
  GetPropertyDisclosureByIdUseCase(this._repository);
  Future<PropertyDisclosure> execute(String id) => _repository.getById(id);
}

class GetPropertyDisclosuresUseCase {
  final PropertyDisclosureRepository _repository;
  GetPropertyDisclosuresUseCase(this._repository);
  Future<List<PropertyDisclosure>> execute({
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

class CreatePropertyDisclosureUseCase {
  final PropertyDisclosureRepository _repository;
  CreatePropertyDisclosureUseCase(this._repository);
  Future<PropertyDisclosure> execute(PropertyDisclosure item) => _repository.create(item);
}

class UpdatePropertyDisclosureUseCase {
  final PropertyDisclosureRepository _repository;
  UpdatePropertyDisclosureUseCase(this._repository);
  Future<PropertyDisclosure> execute(String id, PropertyDisclosure item) => _repository.update(id, item);
}

class DeletePropertyDisclosureUseCase {
  final PropertyDisclosureRepository _repository;
  DeletePropertyDisclosureUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
