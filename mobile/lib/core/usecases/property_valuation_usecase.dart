import '../../features/shared/services/property_valuation_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for PropertyValuation

class GetPropertyValuationByIdUseCase {
  final PropertyValuationService _service;
  
  GetPropertyValuationByIdUseCase(this._service);
  
  Future<PropertyValuation> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetPropertyValuationsUseCase {
  final PropertyValuationService _service;
  
  GetPropertyValuationsUseCase(this._service);
  
  Future<List<PropertyValuation>> execute({
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

class CreatePropertyValuationUseCase {
  final PropertyValuationService _service;
  
  CreatePropertyValuationUseCase(this._service);
  
  Future<PropertyValuation> execute(PropertyValuation propertyValuation) async {
    // Add validation logic here
    return await _service.create(propertyValuation);
  }
}

class UpdatePropertyValuationUseCase {
  final PropertyValuationService _service;
  
  UpdatePropertyValuationUseCase(this._service);
  
  Future<PropertyValuation> execute(String id, PropertyValuation propertyValuation) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, propertyValuation);
  }
}

class DeletePropertyValuationUseCase {
  final PropertyValuationService _service;
  
  DeletePropertyValuationUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// PropertyValuation Use Case Container
class PropertyValuationUseCases {
  final GetPropertyValuationByIdUseCase getById;
  final GetPropertyValuationsUseCase getAll;
  final CreatePropertyValuationUseCase create;
  final UpdatePropertyValuationUseCase update;
  final DeletePropertyValuationUseCase delete;
  
  PropertyValuationUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory PropertyValuationUseCases.create(PropertyValuationService service) {
    return PropertyValuationUseCases(
      getById: GetPropertyValuationByIdUseCase(service),
      getAll: GetPropertyValuationsUseCase(service),
      create: CreatePropertyValuationUseCase(service),
      update: UpdatePropertyValuationUseCase(service),
      delete: DeletePropertyValuationUseCase(service),
    );
  }
}
