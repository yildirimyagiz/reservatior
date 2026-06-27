import 'package:reservatior/shared/repositories/verification_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetVerificationByIdUseCase {
  final VerificationRepository _repository;
  GetVerificationByIdUseCase(this._repository);
  Future<Verification> execute(String id) => _repository.getById(id);
}

class GetVerificationsUseCase {
  final VerificationRepository _repository;
  GetVerificationsUseCase(this._repository);
  Future<List<Verification>> execute({
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

class CreateVerificationUseCase {
  final VerificationRepository _repository;
  CreateVerificationUseCase(this._repository);
  Future<Verification> execute(Verification item) => _repository.create(item);
}

class UpdateVerificationUseCase {
  final VerificationRepository _repository;
  UpdateVerificationUseCase(this._repository);
  Future<Verification> execute(String id, Verification item) => _repository.update(id, item);
}

class DeleteVerificationUseCase {
  final VerificationRepository _repository;
  DeleteVerificationUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
