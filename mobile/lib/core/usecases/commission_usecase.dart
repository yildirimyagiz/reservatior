import '../../features/shared/services/commission_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for Commission

class GetCommissionByIdUseCase {
  final CommissionService _service;
  
  GetCommissionByIdUseCase(this._service);
  
  Future<Commission> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetCommissionsUseCase {
  final CommissionService _service;
  
  GetCommissionsUseCase(this._service);
  
  Future<List<Commission>> execute({
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

class CreateCommissionUseCase {
  final CommissionService _service;
  
  CreateCommissionUseCase(this._service);
  
  Future<Commission> execute(Commission commission) async {
    // Add validation logic here
    return await _service.create(commission);
  }
}

class UpdateCommissionUseCase {
  final CommissionService _service;
  
  UpdateCommissionUseCase(this._service);
  
  Future<Commission> execute(String id, Commission commission) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, commission);
  }
}

class DeleteCommissionUseCase {
  final CommissionService _service;
  
  DeleteCommissionUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// Commission Use Case Container
class CommissionUseCases {
  final GetCommissionByIdUseCase getById;
  final GetCommissionsUseCase getAll;
  final CreateCommissionUseCase create;
  final UpdateCommissionUseCase update;
  final DeleteCommissionUseCase delete;
  
  CommissionUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory CommissionUseCases.create(CommissionService service) {
    return CommissionUseCases(
      getById: GetCommissionByIdUseCase(service),
      getAll: GetCommissionsUseCase(service),
      create: CreateCommissionUseCase(service),
      update: UpdateCommissionUseCase(service),
      delete: DeleteCommissionUseCase(service),
    );
  }
}
