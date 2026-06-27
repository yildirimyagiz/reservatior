import 'package:reservatior/shared/repositories/key_management_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetKeyManagementByIdUseCase {
  final KeyManagementRepository _repository;
  GetKeyManagementByIdUseCase(this._repository);
  Future<KeyManagement> execute(String id) => _repository.getById(id);
}

class GetKeyManagementsUseCase {
  final KeyManagementRepository _repository;
  GetKeyManagementsUseCase(this._repository);
  Future<List<KeyManagement>> execute({
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

class CreateKeyManagementUseCase {
  final KeyManagementRepository _repository;
  CreateKeyManagementUseCase(this._repository);
  Future<KeyManagement> execute(KeyManagement item) => _repository.create(item);
}

class UpdateKeyManagementUseCase {
  final KeyManagementRepository _repository;
  UpdateKeyManagementUseCase(this._repository);
  Future<KeyManagement> execute(String id, KeyManagement item) => _repository.update(id, item);
}

class DeleteKeyManagementUseCase {
  final KeyManagementRepository _repository;
  DeleteKeyManagementUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
