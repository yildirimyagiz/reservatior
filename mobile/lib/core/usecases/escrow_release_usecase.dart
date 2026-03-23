import '../../features/shared/services/escrow_release_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for EscrowRelease

class GetEscrowReleaseByIdUseCase {
  final EscrowReleaseService _service;
  
  GetEscrowReleaseByIdUseCase(this._service);
  
  Future<EscrowRelease> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetEscrowReleasesUseCase {
  final EscrowReleaseService _service;
  
  GetEscrowReleasesUseCase(this._service);
  
  Future<List<EscrowRelease>> execute({
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

class CreateEscrowReleaseUseCase {
  final EscrowReleaseService _service;
  
  CreateEscrowReleaseUseCase(this._service);
  
  Future<EscrowRelease> execute(EscrowRelease escrowRelease) async {
    // Add validation logic here
    return await _service.create(escrowRelease);
  }
}

class UpdateEscrowReleaseUseCase {
  final EscrowReleaseService _service;
  
  UpdateEscrowReleaseUseCase(this._service);
  
  Future<EscrowRelease> execute(String id, EscrowRelease escrowRelease) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, escrowRelease);
  }
}

class DeleteEscrowReleaseUseCase {
  final EscrowReleaseService _service;
  
  DeleteEscrowReleaseUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// EscrowRelease Use Case Container
class EscrowReleaseUseCases {
  final GetEscrowReleaseByIdUseCase getById;
  final GetEscrowReleasesUseCase getAll;
  final CreateEscrowReleaseUseCase create;
  final UpdateEscrowReleaseUseCase update;
  final DeleteEscrowReleaseUseCase delete;
  
  EscrowReleaseUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory EscrowReleaseUseCases.create(EscrowReleaseService service) {
    return EscrowReleaseUseCases(
      getById: GetEscrowReleaseByIdUseCase(service),
      getAll: GetEscrowReleasesUseCase(service),
      create: CreateEscrowReleaseUseCase(service),
      update: UpdateEscrowReleaseUseCase(service),
      delete: DeleteEscrowReleaseUseCase(service),
    );
  }
}
