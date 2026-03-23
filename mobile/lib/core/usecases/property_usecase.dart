import '../../features/shared/services/property_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for Property

class GetPropertyByIdUseCase {
  final PropertyService _service;
  
  GetPropertyByIdUseCase(this._service);
  
  Future<Property> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetPropertysUseCase {
  final PropertyService _service;
  
  GetPropertysUseCase(this._service);
  
  Future<List<Property>> execute({
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

class CreatePropertyUseCase {
  final PropertyService _service;
  
  CreatePropertyUseCase(this._service);
  
  Future<Property> execute(Property property) async {
    // Add validation logic here
    return await _service.create(property);
  }
}

class UpdatePropertyUseCase {
  final PropertyService _service;
  
  UpdatePropertyUseCase(this._service);
  
  Future<Property> execute(String id, Property property) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, property);
  }
}

class DeletePropertyUseCase {
  final PropertyService _service;
  
  DeletePropertyUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// Property Use Case Container
class PropertyUseCases {
  final GetPropertyByIdUseCase getById;
  final GetPropertysUseCase getAll;
  final CreatePropertyUseCase create;
  final UpdatePropertyUseCase update;
  final DeletePropertyUseCase delete;
  
  PropertyUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory PropertyUseCases.create(PropertyService service) {
    return PropertyUseCases(
      getById: GetPropertyByIdUseCase(service),
      getAll: GetPropertysUseCase(service),
      create: CreatePropertyUseCase(service),
      update: UpdatePropertyUseCase(service),
      delete: DeletePropertyUseCase(service),
    );
  }
}
