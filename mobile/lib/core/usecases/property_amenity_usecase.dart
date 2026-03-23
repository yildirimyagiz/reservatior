import '../../features/shared/services/property_amenity_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for PropertyAmenity

class GetPropertyAmenityByIdUseCase {
  final PropertyAmenityService _service;
  
  GetPropertyAmenityByIdUseCase(this._service);
  
  Future<PropertyAmenity> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetPropertyAmenitysUseCase {
  final PropertyAmenityService _service;
  
  GetPropertyAmenitysUseCase(this._service);
  
  Future<List<PropertyAmenity>> execute({
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

class CreatePropertyAmenityUseCase {
  final PropertyAmenityService _service;
  
  CreatePropertyAmenityUseCase(this._service);
  
  Future<PropertyAmenity> execute(PropertyAmenity propertyAmenity) async {
    // Add validation logic here
    return await _service.create(propertyAmenity);
  }
}

class UpdatePropertyAmenityUseCase {
  final PropertyAmenityService _service;
  
  UpdatePropertyAmenityUseCase(this._service);
  
  Future<PropertyAmenity> execute(String id, PropertyAmenity propertyAmenity) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, propertyAmenity);
  }
}

class DeletePropertyAmenityUseCase {
  final PropertyAmenityService _service;
  
  DeletePropertyAmenityUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// PropertyAmenity Use Case Container
class PropertyAmenityUseCases {
  final GetPropertyAmenityByIdUseCase getById;
  final GetPropertyAmenitysUseCase getAll;
  final CreatePropertyAmenityUseCase create;
  final UpdatePropertyAmenityUseCase update;
  final DeletePropertyAmenityUseCase delete;
  
  PropertyAmenityUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory PropertyAmenityUseCases.create(PropertyAmenityService service) {
    return PropertyAmenityUseCases(
      getById: GetPropertyAmenityByIdUseCase(service),
      getAll: GetPropertyAmenitysUseCase(service),
      create: CreatePropertyAmenityUseCase(service),
      update: UpdatePropertyAmenityUseCase(service),
      delete: DeletePropertyAmenityUseCase(service),
    );
  }
}
