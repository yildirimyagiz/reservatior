import '../../features/shared/services/increase_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for Increase

class GetIncreaseByIdUseCase {
  final IncreaseService _service;
  
  GetIncreaseByIdUseCase(this._service);
  
  Future<Increase> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetIncreasesUseCase {
  final IncreaseService _service;
  
  GetIncreasesUseCase(this._service);
  
  Future<List<Increase>> execute({
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

class CreateIncreaseUseCase {
  final IncreaseService _service;
  
  CreateIncreaseUseCase(this._service);
  
  Future<Increase> execute(Increase increase) async {
    // Add validation logic here
    return await _service.create(increase);
  }
}

class UpdateIncreaseUseCase {
  final IncreaseService _service;
  
  UpdateIncreaseUseCase(this._service);
  
  Future<Increase> execute(String id, Increase increase) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, increase);
  }
}

class DeleteIncreaseUseCase {
  final IncreaseService _service;
  
  DeleteIncreaseUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// Increase Use Case Container
class IncreaseUseCases {
  final GetIncreaseByIdUseCase getById;
  final GetIncreasesUseCase getAll;
  final CreateIncreaseUseCase create;
  final UpdateIncreaseUseCase update;
  final DeleteIncreaseUseCase delete;
  
  IncreaseUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory IncreaseUseCases.create(IncreaseService service) {
    return IncreaseUseCases(
      getById: GetIncreaseByIdUseCase(service),
      getAll: GetIncreasesUseCase(service),
      create: CreateIncreaseUseCase(service),
      update: UpdateIncreaseUseCase(service),
      delete: DeleteIncreaseUseCase(service),
    );
  }
}
