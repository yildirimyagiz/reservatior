import 'package:reservatior/shared/repositories/signature_signer_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetSignatureSignerByIdUseCase {
  final SignatureSignerRepository _repository;
  GetSignatureSignerByIdUseCase(this._repository);
  Future<SignatureSigner> execute(String id) => _repository.getById(id);
}

class GetSignatureSignersUseCase {
  final SignatureSignerRepository _repository;
  GetSignatureSignersUseCase(this._repository);
  Future<List<SignatureSigner>> execute({
    int page = 1, 
    int limit = 20, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) => _repository.getAll(
    page: page, 
    limit: limit, 
    filters: filters,
    sortBy: sortBy,
    sortOrder: sortOrder,
  );
}

class CreateSignatureSignerUseCase {
  final SignatureSignerRepository _repository;
  CreateSignatureSignerUseCase(this._repository);
  Future<SignatureSigner> execute(SignatureSigner item) => _repository.create(item);
}

class UpdateSignatureSignerUseCase {
  final SignatureSignerRepository _repository;
  UpdateSignatureSignerUseCase(this._repository);
  Future<SignatureSigner> execute(String id, SignatureSigner item) => _repository.update(id, item);
}

class DeleteSignatureSignerUseCase {
  final SignatureSignerRepository _repository;
  DeleteSignatureSignerUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
