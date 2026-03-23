import '../../features/shared/services/mortgage_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for Mortgage

class GetMortgageByIdUseCase {
  final MortgageService _service;
  
  GetMortgageByIdUseCase(this._service);
  
  Future<Mortgage> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetMortgagesUseCase {
  final MortgageService _service;
  
  GetMortgagesUseCase(this._service);
  
  Future<List<Mortgage>> execute({
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

class CreateMortgageUseCase {
  final MortgageService _service;
  
  CreateMortgageUseCase(this._service);
  
  Future<Mortgage> execute(Mortgage mortgage) async {
    // Add validation logic here
    return await _service.create(mortgage);
  }
}

class UpdateMortgageUseCase {
  final MortgageService _service;
  
  UpdateMortgageUseCase(this._service);
  
  Future<Mortgage> execute(String id, Mortgage mortgage) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, mortgage);
  }
}

class DeleteMortgageUseCase {
  final MortgageService _service;
  
  DeleteMortgageUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// Mortgage Use Case Container
class MortgageUseCases {
  final GetMortgageByIdUseCase getById;
  final GetMortgagesUseCase getAll;
  final CreateMortgageUseCase create;
  final UpdateMortgageUseCase update;
  final DeleteMortgageUseCase delete;
  
  MortgageUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory MortgageUseCases.create(MortgageService service) {
    return MortgageUseCases(
      getById: GetMortgageByIdUseCase(service),
      getAll: GetMortgagesUseCase(service),
      create: CreateMortgageUseCase(service),
      update: UpdateMortgageUseCase(service),
      delete: DeleteMortgageUseCase(service),
    );
  }
}
