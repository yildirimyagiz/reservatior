import '../../features/shared/services/property_viewing_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for PropertyViewing

class GetPropertyViewingByIdUseCase {
  final PropertyViewingService _service;
  
  GetPropertyViewingByIdUseCase(this._service);
  
  Future<PropertyViewing> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetPropertyViewingsUseCase {
  final PropertyViewingService _service;
  
  GetPropertyViewingsUseCase(this._service);
  
  Future<List<PropertyViewing>> execute({
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

class CreatePropertyViewingUseCase {
  final PropertyViewingService _service;
  
  CreatePropertyViewingUseCase(this._service);
  
  Future<PropertyViewing> execute(PropertyViewing propertyViewing) async {
    // Add validation logic here
    return await _service.create(propertyViewing);
  }
}

class UpdatePropertyViewingUseCase {
  final PropertyViewingService _service;
  
  UpdatePropertyViewingUseCase(this._service);
  
  Future<PropertyViewing> execute(String id, PropertyViewing propertyViewing) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, propertyViewing);
  }
}

class DeletePropertyViewingUseCase {
  final PropertyViewingService _service;
  
  DeletePropertyViewingUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// PropertyViewing Use Case Container
class PropertyViewingUseCases {
  final GetPropertyViewingByIdUseCase getById;
  final GetPropertyViewingsUseCase getAll;
  final CreatePropertyViewingUseCase create;
  final UpdatePropertyViewingUseCase update;
  final DeletePropertyViewingUseCase delete;
  
  PropertyViewingUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory PropertyViewingUseCases.create(PropertyViewingService service) {
    return PropertyViewingUseCases(
      getById: GetPropertyViewingByIdUseCase(service),
      getAll: GetPropertyViewingsUseCase(service),
      create: CreatePropertyViewingUseCase(service),
      update: UpdatePropertyViewingUseCase(service),
      delete: DeletePropertyViewingUseCase(service),
    );
  }
}
