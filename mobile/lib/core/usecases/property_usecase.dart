import 'package:reservatior/shared/repositories/property_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetPropertyByIdUseCase {
  final PropertyRepository _repository;
  GetPropertyByIdUseCase(this._repository);
  Future<Property> execute(String id) => _repository.getById(id);
}

class GetPropertysUseCase {
  final PropertyRepository _repository;
  GetPropertysUseCase(this._repository);
  Future<List<Property>> execute({
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

class CreatePropertyUseCase {
  final PropertyRepository _repository;
  CreatePropertyUseCase(this._repository);
  Future<Property> execute(Property item) => _repository.create(item);
}

class UpdatePropertyUseCase {
  final PropertyRepository _repository;
  UpdatePropertyUseCase(this._repository);
  Future<Property> execute(String id, Property item) => _repository.update(id, item);
}

class DeletePropertyUseCase {
  final PropertyRepository _repository;
  DeletePropertyUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
