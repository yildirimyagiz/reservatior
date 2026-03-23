import '../../features/shared/services/organization_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for Organization

class GetOrganizationByIdUseCase {
  final OrganizationService _service;
  
  GetOrganizationByIdUseCase(this._service);
  
  Future<Organization> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetOrganizationsUseCase {
  final OrganizationService _service;
  
  GetOrganizationsUseCase(this._service);
  
  Future<List<Organization>> execute({
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

class CreateOrganizationUseCase {
  final OrganizationService _service;
  
  CreateOrganizationUseCase(this._service);
  
  Future<Organization> execute(Organization organization) async {
    // Add validation logic here
    return await _service.create(organization);
  }
}

class UpdateOrganizationUseCase {
  final OrganizationService _service;
  
  UpdateOrganizationUseCase(this._service);
  
  Future<Organization> execute(String id, Organization organization) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, organization);
  }
}

class DeleteOrganizationUseCase {
  final OrganizationService _service;
  
  DeleteOrganizationUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// Organization Use Case Container
class OrganizationUseCases {
  final GetOrganizationByIdUseCase getById;
  final GetOrganizationsUseCase getAll;
  final CreateOrganizationUseCase create;
  final UpdateOrganizationUseCase update;
  final DeleteOrganizationUseCase delete;
  
  OrganizationUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory OrganizationUseCases.create(OrganizationService service) {
    return OrganizationUseCases(
      getById: GetOrganizationByIdUseCase(service),
      getAll: GetOrganizationsUseCase(service),
      create: CreateOrganizationUseCase(service),
      update: UpdateOrganizationUseCase(service),
      delete: DeleteOrganizationUseCase(service),
    );
  }
}
