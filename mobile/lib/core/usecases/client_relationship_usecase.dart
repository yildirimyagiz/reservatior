import 'package:reservatior/shared/repositories/client_relationship_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetClientRelationshipByIdUseCase {
  final ClientRelationshipRepository _repository;
  GetClientRelationshipByIdUseCase(this._repository);
  Future<ClientRelationship> execute(String id) => _repository.getById(id);
}

class GetClientRelationshipsUseCase {
  final ClientRelationshipRepository _repository;
  GetClientRelationshipsUseCase(this._repository);
  Future<List<ClientRelationship>> execute({
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

class CreateClientRelationshipUseCase {
  final ClientRelationshipRepository _repository;
  CreateClientRelationshipUseCase(this._repository);
  Future<ClientRelationship> execute(ClientRelationship item) => _repository.create(item);
}

class UpdateClientRelationshipUseCase {
  final ClientRelationshipRepository _repository;
  UpdateClientRelationshipUseCase(this._repository);
  Future<ClientRelationship> execute(String id, ClientRelationship item) => _repository.update(id, item);
}

class DeleteClientRelationshipUseCase {
  final ClientRelationshipRepository _repository;
  DeleteClientRelationshipUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
