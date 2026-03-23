import '../../features/shared/services/signature_signer_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for SignatureSigner

class GetSignatureSignerByIdUseCase {
  final SignatureSignerService _service;
  
  GetSignatureSignerByIdUseCase(this._service);
  
  Future<SignatureSigner> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetSignatureSignersUseCase {
  final SignatureSignerService _service;
  
  GetSignatureSignersUseCase(this._service);
  
  Future<List<SignatureSigner>> execute({
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

class CreateSignatureSignerUseCase {
  final SignatureSignerService _service;
  
  CreateSignatureSignerUseCase(this._service);
  
  Future<SignatureSigner> execute(SignatureSigner signatureSigner) async {
    // Add validation logic here
    return await _service.create(signatureSigner);
  }
}

class UpdateSignatureSignerUseCase {
  final SignatureSignerService _service;
  
  UpdateSignatureSignerUseCase(this._service);
  
  Future<SignatureSigner> execute(String id, SignatureSigner signatureSigner) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, signatureSigner);
  }
}

class DeleteSignatureSignerUseCase {
  final SignatureSignerService _service;
  
  DeleteSignatureSignerUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// SignatureSigner Use Case Container
class SignatureSignerUseCases {
  final GetSignatureSignerByIdUseCase getById;
  final GetSignatureSignersUseCase getAll;
  final CreateSignatureSignerUseCase create;
  final UpdateSignatureSignerUseCase update;
  final DeleteSignatureSignerUseCase delete;
  
  SignatureSignerUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory SignatureSignerUseCases.create(SignatureSignerService service) {
    return SignatureSignerUseCases(
      getById: GetSignatureSignerByIdUseCase(service),
      getAll: GetSignatureSignersUseCase(service),
      create: CreateSignatureSignerUseCase(service),
      update: UpdateSignatureSignerUseCase(service),
      delete: DeleteSignatureSignerUseCase(service),
    );
  }
}
