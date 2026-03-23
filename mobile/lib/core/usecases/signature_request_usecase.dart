import '../../features/shared/services/signature_request_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for SignatureRequest

class GetSignatureRequestByIdUseCase {
  final SignatureRequestService _service;
  
  GetSignatureRequestByIdUseCase(this._service);
  
  Future<SignatureRequest> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetSignatureRequestsUseCase {
  final SignatureRequestService _service;
  
  GetSignatureRequestsUseCase(this._service);
  
  Future<List<SignatureRequest>> execute({
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

class CreateSignatureRequestUseCase {
  final SignatureRequestService _service;
  
  CreateSignatureRequestUseCase(this._service);
  
  Future<SignatureRequest> execute(SignatureRequest signatureRequest) async {
    // Add validation logic here
    return await _service.create(signatureRequest);
  }
}

class UpdateSignatureRequestUseCase {
  final SignatureRequestService _service;
  
  UpdateSignatureRequestUseCase(this._service);
  
  Future<SignatureRequest> execute(String id, SignatureRequest signatureRequest) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, signatureRequest);
  }
}

class DeleteSignatureRequestUseCase {
  final SignatureRequestService _service;
  
  DeleteSignatureRequestUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// SignatureRequest Use Case Container
class SignatureRequestUseCases {
  final GetSignatureRequestByIdUseCase getById;
  final GetSignatureRequestsUseCase getAll;
  final CreateSignatureRequestUseCase create;
  final UpdateSignatureRequestUseCase update;
  final DeleteSignatureRequestUseCase delete;
  
  SignatureRequestUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory SignatureRequestUseCases.create(SignatureRequestService service) {
    return SignatureRequestUseCases(
      getById: GetSignatureRequestByIdUseCase(service),
      getAll: GetSignatureRequestsUseCase(service),
      create: CreateSignatureRequestUseCase(service),
      update: UpdateSignatureRequestUseCase(service),
      delete: DeleteSignatureRequestUseCase(service),
    );
  }
}
