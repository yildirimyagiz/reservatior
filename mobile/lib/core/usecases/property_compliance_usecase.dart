import '../../features/shared/services/property_compliance_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for PropertyCompliance

class GetPropertyComplianceByIdUseCase {
  final PropertyComplianceService _service;
  
  GetPropertyComplianceByIdUseCase(this._service);
  
  Future<PropertyCompliance> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetPropertyCompliancesUseCase {
  final PropertyComplianceService _service;
  
  GetPropertyCompliancesUseCase(this._service);
  
  Future<List<PropertyCompliance>> execute({
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

class CreatePropertyComplianceUseCase {
  final PropertyComplianceService _service;
  
  CreatePropertyComplianceUseCase(this._service);
  
  Future<PropertyCompliance> execute(PropertyCompliance propertyCompliance) async {
    // Add validation logic here
    return await _service.create(propertyCompliance);
  }
}

class UpdatePropertyComplianceUseCase {
  final PropertyComplianceService _service;
  
  UpdatePropertyComplianceUseCase(this._service);
  
  Future<PropertyCompliance> execute(String id, PropertyCompliance propertyCompliance) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, propertyCompliance);
  }
}

class DeletePropertyComplianceUseCase {
  final PropertyComplianceService _service;
  
  DeletePropertyComplianceUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// PropertyCompliance Use Case Container
class PropertyComplianceUseCases {
  final GetPropertyComplianceByIdUseCase getById;
  final GetPropertyCompliancesUseCase getAll;
  final CreatePropertyComplianceUseCase create;
  final UpdatePropertyComplianceUseCase update;
  final DeletePropertyComplianceUseCase delete;
  
  PropertyComplianceUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory PropertyComplianceUseCases.create(PropertyComplianceService service) {
    return PropertyComplianceUseCases(
      getById: GetPropertyComplianceByIdUseCase(service),
      getAll: GetPropertyCompliancesUseCase(service),
      create: CreatePropertyComplianceUseCase(service),
      update: UpdatePropertyComplianceUseCase(service),
      delete: DeletePropertyComplianceUseCase(service),
    );
  }
}
