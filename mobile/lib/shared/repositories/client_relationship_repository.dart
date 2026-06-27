import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/client_relationship_service.dart';

abstract class ClientRelationshipRepository {
  Future<ClientRelationship> getById(String id);
  Future<List<ClientRelationship>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<ClientRelationship> create(ClientRelationship item);
  Future<ClientRelationship> update(String id, ClientRelationship item);
  Future<void> delete(String id);
}

class ClientRelationshipRepositoryImpl implements ClientRelationshipRepository {
  final ClientRelationshipService _service;
  ClientRelationshipRepositoryImpl(this._service);

  @override
  Future<ClientRelationship> getById(String id) => _service.getClientRelationshipById(id);

  @override
  Future<List<ClientRelationship>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getClientRelationships(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<ClientRelationship> create(ClientRelationship item) => _service.createClientRelationship(item);

  @override
  Future<ClientRelationship> update(String id, ClientRelationship item) => _service.updateClientRelationship(id, item);

  @override
  Future<void> delete(String id) => _service.deleteClientRelationship(id);
}
