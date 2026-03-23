import '../../features/shared/services/rent_arrears_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for RentArrears

class GetRentArrearsByIdUseCase {
  final RentArrearsService _service;
  
  GetRentArrearsByIdUseCase(this._service);
  
  Future<RentArrears> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetRentArrearssUseCase {
  final RentArrearsService _service;
  
  GetRentArrearssUseCase(this._service);
  
  Future<List<RentArrears>> execute({
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

class CreateRentArrearsUseCase {
  final RentArrearsService _service;
  
  CreateRentArrearsUseCase(this._service);
  
  Future<RentArrears> execute(RentArrears rentArrears) async {
    // Add validation logic here
    return await _service.create(rentArrears);
  }
}

class UpdateRentArrearsUseCase {
  final RentArrearsService _service;
  
  UpdateRentArrearsUseCase(this._service);
  
  Future<RentArrears> execute(String id, RentArrears rentArrears) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, rentArrears);
  }
}

class DeleteRentArrearsUseCase {
  final RentArrearsService _service;
  
  DeleteRentArrearsUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// RentArrears Use Case Container
class RentArrearsUseCases {
  final GetRentArrearsByIdUseCase getById;
  final GetRentArrearssUseCase getAll;
  final CreateRentArrearsUseCase create;
  final UpdateRentArrearsUseCase update;
  final DeleteRentArrearsUseCase delete;
  
  RentArrearsUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory RentArrearsUseCases.create(RentArrearsService service) {
    return RentArrearsUseCases(
      getById: GetRentArrearsByIdUseCase(service),
      getAll: GetRentArrearssUseCase(service),
      create: CreateRentArrearsUseCase(service),
      update: UpdateRentArrearsUseCase(service),
      delete: DeleteRentArrearsUseCase(service),
    );
  }
}
