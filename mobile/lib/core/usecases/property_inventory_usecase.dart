import '../../features/shared/services/property_inventory_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for PropertyInventory

class GetPropertyInventoryByIdUseCase {
  final PropertyInventoryService _service;
  
  GetPropertyInventoryByIdUseCase(this._service);
  
  Future<PropertyInventory> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetPropertyInventorysUseCase {
  final PropertyInventoryService _service;
  
  GetPropertyInventorysUseCase(this._service);
  
  Future<List<PropertyInventory>> execute({
    int page = 1,
    int limit = 20,
    Map<String, dynamic>? filters,
  }) async {
    if (page <= 0) {
      throw ArgumentError('Page must be greater than 0');
    }
    if (limit <= 0 || limit > 100) {
      throw ArgumentError('Limit must be between 1 and 100');
    }
    return await _service.getAll(
      page: page,
      limit: limit,
      filters: filters,
    );
  }
}

class CreatePropertyInventoryUseCase {
  final PropertyInventoryService _service;
  
  CreatePropertyInventoryUseCase(this._service);
  
  Future<PropertyInventory> execute(PropertyInventory propertyInventory) async {
    // Add validation logic here
    return await _service.create(propertyInventory);
  }
}

class UpdatePropertyInventoryUseCase {
  final PropertyInventoryService _service;
  
  UpdatePropertyInventoryUseCase(this._service);
  
  Future<PropertyInventory> execute(String id, PropertyInventory propertyInventory) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, propertyInventory);
  }
}

class DeletePropertyInventoryUseCase {
  final PropertyInventoryService _service;
  
  DeletePropertyInventoryUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// PropertyInventory Use Case Container
class PropertyInventoryUseCases {
  final GetPropertyInventoryByIdUseCase getById;
  final GetPropertyInventorysUseCase getAll;
  final CreatePropertyInventoryUseCase create;
  final UpdatePropertyInventoryUseCase update;
  final DeletePropertyInventoryUseCase delete;
  
  PropertyInventoryUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory PropertyInventoryUseCases.create(PropertyInventoryService service) {
    return PropertyInventoryUseCases(
      getById: GetPropertyInventoryByIdUseCase(service),
      getAll: GetPropertyInventorysUseCase(service),
      create: CreatePropertyInventoryUseCase(service),
      update: UpdatePropertyInventoryUseCase(service),
      delete: DeletePropertyInventoryUseCase(service),
    );
  }
}
