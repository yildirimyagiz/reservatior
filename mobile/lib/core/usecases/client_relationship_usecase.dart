import '../../features/shared/services/client_relationship_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for ClientRelationship

class GetClientRelationshipByIdUseCase {
  final ClientRelationshipService _service;
  
  GetClientRelationshipByIdUseCase(this._service);
  
  Future<ClientRelationship> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetClientRelationshipsUseCase {
  final ClientRelationshipService _service;
  
  GetClientRelationshipsUseCase(this._service);
  
  Future<List<ClientRelationship>> execute({
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

class CreateClientRelationshipUseCase {
  final ClientRelationshipService _service;
  
  CreateClientRelationshipUseCase(this._service);
  
  Future<ClientRelationship> execute(ClientRelationship clientRelationship) async {
    // Add validation logic here
    return await _service.create(clientRelationship);
  }
}

class UpdateClientRelationshipUseCase {
  final ClientRelationshipService _service;
  
  UpdateClientRelationshipUseCase(this._service);
  
  Future<ClientRelationship> execute(String id, ClientRelationship clientRelationship) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, clientRelationship);
  }
}

class DeleteClientRelationshipUseCase {
  final ClientRelationshipService _service;
  
  DeleteClientRelationshipUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// ClientRelationship Use Case Container
class ClientRelationshipUseCases {
  final GetClientRelationshipByIdUseCase getById;
  final GetClientRelationshipsUseCase getAll;
  final CreateClientRelationshipUseCase create;
  final UpdateClientRelationshipUseCase update;
  final DeleteClientRelationshipUseCase delete;
  
  ClientRelationshipUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory ClientRelationshipUseCases.create(ClientRelationshipService service) {
    return ClientRelationshipUseCases(
      getById: GetClientRelationshipByIdUseCase(service),
      getAll: GetClientRelationshipsUseCase(service),
      create: CreateClientRelationshipUseCase(service),
      update: UpdateClientRelationshipUseCase(service),
      delete: DeleteClientRelationshipUseCase(service),
    );
  }
}
