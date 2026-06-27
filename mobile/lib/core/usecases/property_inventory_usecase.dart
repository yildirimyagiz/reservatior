import 'package:reservatior/shared/repositories/property_inventory_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetPropertyInventoryByIdUseCase {
  final PropertyInventoryRepository _repository;
  GetPropertyInventoryByIdUseCase(this._repository);
  Future<PropertyInventory> execute(String id) => _repository.getById(id);
}

class GetPropertyInventorysUseCase {
  final PropertyInventoryRepository _repository;
  GetPropertyInventorysUseCase(this._repository);
  Future<List<PropertyInventory>> execute({
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

class CreatePropertyInventoryUseCase {
  final PropertyInventoryRepository _repository;
  CreatePropertyInventoryUseCase(this._repository);
  Future<PropertyInventory> execute(PropertyInventory item) => _repository.create(item);
}

class UpdatePropertyInventoryUseCase {
  final PropertyInventoryRepository _repository;
  UpdatePropertyInventoryUseCase(this._repository);
  Future<PropertyInventory> execute(String id, PropertyInventory item) => _repository.update(id, item);
}

class DeletePropertyInventoryUseCase {
  final PropertyInventoryRepository _repository;
  DeletePropertyInventoryUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
