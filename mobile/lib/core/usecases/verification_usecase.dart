import '../../features/shared/services/verification_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for Verification

class GetVerificationByIdUseCase {
  final VerificationService _service;
  
  GetVerificationByIdUseCase(this._service);
  
  Future<Verification> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetVerificationsUseCase {
  final VerificationService _service;
  
  GetVerificationsUseCase(this._service);
  
  Future<List<Verification>> execute({
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

class CreateVerificationUseCase {
  final VerificationService _service;
  
  CreateVerificationUseCase(this._service);
  
  Future<Verification> execute(Verification verification) async {
    // Add validation logic here
    return await _service.create(verification);
  }
}

class UpdateVerificationUseCase {
  final VerificationService _service;
  
  UpdateVerificationUseCase(this._service);
  
  Future<Verification> execute(String id, Verification verification) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, verification);
  }
}

class DeleteVerificationUseCase {
  final VerificationService _service;
  
  DeleteVerificationUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// Verification Use Case Container
class VerificationUseCases {
  final GetVerificationByIdUseCase getById;
  final GetVerificationsUseCase getAll;
  final CreateVerificationUseCase create;
  final UpdateVerificationUseCase update;
  final DeleteVerificationUseCase delete;
  
  VerificationUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory VerificationUseCases.create(VerificationService service) {
    return VerificationUseCases(
      getById: GetVerificationByIdUseCase(service),
      getAll: GetVerificationsUseCase(service),
      create: CreateVerificationUseCase(service),
      update: UpdateVerificationUseCase(service),
      delete: DeleteVerificationUseCase(service),
    );
  }
}
