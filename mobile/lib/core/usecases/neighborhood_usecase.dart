import '../../features/shared/services/neighborhood_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for Neighborhood

class GetNeighborhoodByIdUseCase {
  final NeighborhoodService _service;
  
  GetNeighborhoodByIdUseCase(this._service);
  
  Future<Neighborhood> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetNeighborhoodsUseCase {
  final NeighborhoodService _service;
  
  GetNeighborhoodsUseCase(this._service);
  
  Future<List<Neighborhood>> execute({
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

class CreateNeighborhoodUseCase {
  final NeighborhoodService _service;
  
  CreateNeighborhoodUseCase(this._service);
  
  Future<Neighborhood> execute(Neighborhood neighborhood) async {
    // Add validation logic here
    return await _service.create(neighborhood);
  }
}

class UpdateNeighborhoodUseCase {
  final NeighborhoodService _service;
  
  UpdateNeighborhoodUseCase(this._service);
  
  Future<Neighborhood> execute(String id, Neighborhood neighborhood) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, neighborhood);
  }
}

class DeleteNeighborhoodUseCase {
  final NeighborhoodService _service;
  
  DeleteNeighborhoodUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// Neighborhood Use Case Container
class NeighborhoodUseCases {
  final GetNeighborhoodByIdUseCase getById;
  final GetNeighborhoodsUseCase getAll;
  final CreateNeighborhoodUseCase create;
  final UpdateNeighborhoodUseCase update;
  final DeleteNeighborhoodUseCase delete;
  
  NeighborhoodUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory NeighborhoodUseCases.create(NeighborhoodService service) {
    return NeighborhoodUseCases(
      getById: GetNeighborhoodByIdUseCase(service),
      getAll: GetNeighborhoodsUseCase(service),
      create: CreateNeighborhoodUseCase(service),
      update: UpdateNeighborhoodUseCase(service),
      delete: DeleteNeighborhoodUseCase(service),
    );
  }
}
