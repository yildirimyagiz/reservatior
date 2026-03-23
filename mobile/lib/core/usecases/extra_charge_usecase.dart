import '../../features/shared/services/extra_charge_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for ExtraCharge

class GetExtraChargeByIdUseCase {
  final ExtraChargeService _service;
  
  GetExtraChargeByIdUseCase(this._service);
  
  Future<ExtraCharge> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetExtraChargesUseCase {
  final ExtraChargeService _service;
  
  GetExtraChargesUseCase(this._service);
  
  Future<List<ExtraCharge>> execute({
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

class CreateExtraChargeUseCase {
  final ExtraChargeService _service;
  
  CreateExtraChargeUseCase(this._service);
  
  Future<ExtraCharge> execute(ExtraCharge extraCharge) async {
    // Add validation logic here
    return await _service.create(extraCharge);
  }
}

class UpdateExtraChargeUseCase {
  final ExtraChargeService _service;
  
  UpdateExtraChargeUseCase(this._service);
  
  Future<ExtraCharge> execute(String id, ExtraCharge extraCharge) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, extraCharge);
  }
}

class DeleteExtraChargeUseCase {
  final ExtraChargeService _service;
  
  DeleteExtraChargeUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// ExtraCharge Use Case Container
class ExtraChargeUseCases {
  final GetExtraChargeByIdUseCase getById;
  final GetExtraChargesUseCase getAll;
  final CreateExtraChargeUseCase create;
  final UpdateExtraChargeUseCase update;
  final DeleteExtraChargeUseCase delete;
  
  ExtraChargeUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory ExtraChargeUseCases.create(ExtraChargeService service) {
    return ExtraChargeUseCases(
      getById: GetExtraChargeByIdUseCase(service),
      getAll: GetExtraChargesUseCase(service),
      create: CreateExtraChargeUseCase(service),
      update: UpdateExtraChargeUseCase(service),
      delete: DeleteExtraChargeUseCase(service),
    );
  }
}
