import '../../features/shared/services/right_to_rent_check_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for RightToRentCheck

class GetRightToRentCheckByIdUseCase {
  final RightToRentCheckService _service;
  
  GetRightToRentCheckByIdUseCase(this._service);
  
  Future<RightToRentCheck> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetRightToRentChecksUseCase {
  final RightToRentCheckService _service;
  
  GetRightToRentChecksUseCase(this._service);
  
  Future<List<RightToRentCheck>> execute({
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

class CreateRightToRentCheckUseCase {
  final RightToRentCheckService _service;
  
  CreateRightToRentCheckUseCase(this._service);
  
  Future<RightToRentCheck> execute(RightToRentCheck rightToRentCheck) async {
    // Add validation logic here
    return await _service.create(rightToRentCheck);
  }
}

class UpdateRightToRentCheckUseCase {
  final RightToRentCheckService _service;
  
  UpdateRightToRentCheckUseCase(this._service);
  
  Future<RightToRentCheck> execute(String id, RightToRentCheck rightToRentCheck) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, rightToRentCheck);
  }
}

class DeleteRightToRentCheckUseCase {
  final RightToRentCheckService _service;
  
  DeleteRightToRentCheckUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// RightToRentCheck Use Case Container
class RightToRentCheckUseCases {
  final GetRightToRentCheckByIdUseCase getById;
  final GetRightToRentChecksUseCase getAll;
  final CreateRightToRentCheckUseCase create;
  final UpdateRightToRentCheckUseCase update;
  final DeleteRightToRentCheckUseCase delete;
  
  RightToRentCheckUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory RightToRentCheckUseCases.create(RightToRentCheckService service) {
    return RightToRentCheckUseCases(
      getById: GetRightToRentCheckByIdUseCase(service),
      getAll: GetRightToRentChecksUseCase(service),
      create: CreateRightToRentCheckUseCase(service),
      update: UpdateRightToRentCheckUseCase(service),
      delete: DeleteRightToRentCheckUseCase(service),
    );
  }
}
