import 'package:reservatior/shared/repositories/property_viewing_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetPropertyViewingByIdUseCase {
  final PropertyViewingRepository _repository;
  GetPropertyViewingByIdUseCase(this._repository);
  Future<PropertyViewing> execute(String id) => _repository.getById(id);
}

class GetPropertyViewingsUseCase {
  final PropertyViewingRepository _repository;
  GetPropertyViewingsUseCase(this._repository);
  Future<List<PropertyViewing>> execute({
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

class CreatePropertyViewingUseCase {
  final PropertyViewingRepository _repository;
  CreatePropertyViewingUseCase(this._repository);
  Future<PropertyViewing> execute(PropertyViewing item) => _repository.create(item);
}

class UpdatePropertyViewingUseCase {
  final PropertyViewingRepository _repository;
  UpdatePropertyViewingUseCase(this._repository);
  Future<PropertyViewing> execute(String id, PropertyViewing item) => _repository.update(id, item);
}

class DeletePropertyViewingUseCase {
  final PropertyViewingRepository _repository;
  DeletePropertyViewingUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
