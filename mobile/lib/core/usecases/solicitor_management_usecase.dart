import '../../features/shared/services/solicitor_management_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for SolicitorManagement

class GetSolicitorManagementByIdUseCase {
  final SolicitorManagementService _service;
  
  GetSolicitorManagementByIdUseCase(this._service);
  
  Future<SolicitorManagement> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetSolicitorManagementsUseCase {
  final SolicitorManagementService _service;
  
  GetSolicitorManagementsUseCase(this._service);
  
  Future<List<SolicitorManagement>> execute({
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

class CreateSolicitorManagementUseCase {
  final SolicitorManagementService _service;
  
  CreateSolicitorManagementUseCase(this._service);
  
  Future<SolicitorManagement> execute(SolicitorManagement solicitorManagement) async {
    // Add validation logic here
    return await _service.create(solicitorManagement);
  }
}

class UpdateSolicitorManagementUseCase {
  final SolicitorManagementService _service;
  
  UpdateSolicitorManagementUseCase(this._service);
  
  Future<SolicitorManagement> execute(String id, SolicitorManagement solicitorManagement) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, solicitorManagement);
  }
}

class DeleteSolicitorManagementUseCase {
  final SolicitorManagementService _service;
  
  DeleteSolicitorManagementUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// SolicitorManagement Use Case Container
class SolicitorManagementUseCases {
  final GetSolicitorManagementByIdUseCase getById;
  final GetSolicitorManagementsUseCase getAll;
  final CreateSolicitorManagementUseCase create;
  final UpdateSolicitorManagementUseCase update;
  final DeleteSolicitorManagementUseCase delete;
  
  SolicitorManagementUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory SolicitorManagementUseCases.create(SolicitorManagementService service) {
    return SolicitorManagementUseCases(
      getById: GetSolicitorManagementByIdUseCase(service),
      getAll: GetSolicitorManagementsUseCase(service),
      create: CreateSolicitorManagementUseCase(service),
      update: UpdateSolicitorManagementUseCase(service),
      delete: DeleteSolicitorManagementUseCase(service),
    );
  }
}
