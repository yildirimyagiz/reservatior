import 'package:reservatior/shared/repositories/signature_request_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetSignatureRequestByIdUseCase {
  final SignatureRequestRepository _repository;
  GetSignatureRequestByIdUseCase(this._repository);
  Future<SignatureRequest> execute(String id) => _repository.getById(id);
}

class GetSignatureRequestsUseCase {
  final SignatureRequestRepository _repository;
  GetSignatureRequestsUseCase(this._repository);
  Future<List<SignatureRequest>> execute({
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

class CreateSignatureRequestUseCase {
  final SignatureRequestRepository _repository;
  CreateSignatureRequestUseCase(this._repository);
  Future<SignatureRequest> execute(SignatureRequest item) => _repository.create(item);
}

class UpdateSignatureRequestUseCase {
  final SignatureRequestRepository _repository;
  UpdateSignatureRequestUseCase(this._repository);
  Future<SignatureRequest> execute(String id, SignatureRequest item) => _repository.update(id, item);
}

class DeleteSignatureRequestUseCase {
  final SignatureRequestRepository _repository;
  DeleteSignatureRequestUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
