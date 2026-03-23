import '../../features/shared/services/attorney_management_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for AttorneyManagement

class GetAttorneyManagementByIdUseCase {
  final AttorneyManagementService _service;
  
  GetAttorneyManagementByIdUseCase(this._service);
  
  Future<AttorneyManagement> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetAttorneyManagementsUseCase {
  final AttorneyManagementService _service;
  
  GetAttorneyManagementsUseCase(this._service);
  
  Future<List<AttorneyManagement>> execute({
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

class CreateAttorneyManagementUseCase {
  final AttorneyManagementService _service;
  
  CreateAttorneyManagementUseCase(this._service);
  
  Future<AttorneyManagement> execute(AttorneyManagement attorneyManagement) async {
    // Add validation logic here
    return await _service.create(attorneyManagement);
  }
}

class UpdateAttorneyManagementUseCase {
  final AttorneyManagementService _service;
  
  UpdateAttorneyManagementUseCase(this._service);
  
  Future<AttorneyManagement> execute(String id, AttorneyManagement attorneyManagement) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, attorneyManagement);
  }
}

class DeleteAttorneyManagementUseCase {
  final AttorneyManagementService _service;
  
  DeleteAttorneyManagementUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// AttorneyManagement Use Case Container
class AttorneyManagementUseCases {
  final GetAttorneyManagementByIdUseCase getById;
  final GetAttorneyManagementsUseCase getAll;
  final CreateAttorneyManagementUseCase create;
  final UpdateAttorneyManagementUseCase update;
  final DeleteAttorneyManagementUseCase delete;
  
  AttorneyManagementUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory AttorneyManagementUseCases.create(AttorneyManagementService service) {
    return AttorneyManagementUseCases(
      getById: GetAttorneyManagementByIdUseCase(service),
      getAll: GetAttorneyManagementsUseCase(service),
      create: CreateAttorneyManagementUseCase(service),
      update: UpdateAttorneyManagementUseCase(service),
      delete: DeleteAttorneyManagementUseCase(service),
    );
  }
}
