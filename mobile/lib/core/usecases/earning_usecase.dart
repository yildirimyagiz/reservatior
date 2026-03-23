import '../../features/shared/services/earning_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for Earning

class GetEarningByIdUseCase {
  final EarningService _service;
  
  GetEarningByIdUseCase(this._service);
  
  Future<Earning> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetEarningsUseCase {
  final EarningService _service;
  
  GetEarningsUseCase(this._service);
  
  Future<List<Earning>> execute({
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

class CreateEarningUseCase {
  final EarningService _service;
  
  CreateEarningUseCase(this._service);
  
  Future<Earning> execute(Earning earning) async {
    // Add validation logic here
    return await _service.create(earning);
  }
}

class UpdateEarningUseCase {
  final EarningService _service;
  
  UpdateEarningUseCase(this._service);
  
  Future<Earning> execute(String id, Earning earning) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, earning);
  }
}

class DeleteEarningUseCase {
  final EarningService _service;
  
  DeleteEarningUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// Earning Use Case Container
class EarningUseCases {
  final GetEarningByIdUseCase getById;
  final GetEarningsUseCase getAll;
  final CreateEarningUseCase create;
  final UpdateEarningUseCase update;
  final DeleteEarningUseCase delete;
  
  EarningUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory EarningUseCases.create(EarningService service) {
    return EarningUseCases(
      getById: GetEarningByIdUseCase(service),
      getAll: GetEarningsUseCase(service),
      create: CreateEarningUseCase(service),
      update: UpdateEarningUseCase(service),
      delete: DeleteEarningUseCase(service),
    );
  }
}
