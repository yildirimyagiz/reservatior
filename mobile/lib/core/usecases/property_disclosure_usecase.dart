import '../../features/shared/services/property_disclosure_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for PropertyDisclosure

class GetPropertyDisclosureByIdUseCase {
  final PropertyDisclosureService _service;
  
  GetPropertyDisclosureByIdUseCase(this._service);
  
  Future<PropertyDisclosure> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetPropertyDisclosuresUseCase {
  final PropertyDisclosureService _service;
  
  GetPropertyDisclosuresUseCase(this._service);
  
  Future<List<PropertyDisclosure>> execute({
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

class CreatePropertyDisclosureUseCase {
  final PropertyDisclosureService _service;
  
  CreatePropertyDisclosureUseCase(this._service);
  
  Future<PropertyDisclosure> execute(PropertyDisclosure propertyDisclosure) async {
    // Add validation logic here
    return await _service.create(propertyDisclosure);
  }
}

class UpdatePropertyDisclosureUseCase {
  final PropertyDisclosureService _service;
  
  UpdatePropertyDisclosureUseCase(this._service);
  
  Future<PropertyDisclosure> execute(String id, PropertyDisclosure propertyDisclosure) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, propertyDisclosure);
  }
}

class DeletePropertyDisclosureUseCase {
  final PropertyDisclosureService _service;
  
  DeletePropertyDisclosureUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// PropertyDisclosure Use Case Container
class PropertyDisclosureUseCases {
  final GetPropertyDisclosureByIdUseCase getById;
  final GetPropertyDisclosuresUseCase getAll;
  final CreatePropertyDisclosureUseCase create;
  final UpdatePropertyDisclosureUseCase update;
  final DeletePropertyDisclosureUseCase delete;
  
  PropertyDisclosureUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory PropertyDisclosureUseCases.create(PropertyDisclosureService service) {
    return PropertyDisclosureUseCases(
      getById: GetPropertyDisclosureByIdUseCase(service),
      getAll: GetPropertyDisclosuresUseCase(service),
      create: CreatePropertyDisclosureUseCase(service),
      update: UpdatePropertyDisclosureUseCase(service),
      delete: DeletePropertyDisclosureUseCase(service),
    );
  }
}
