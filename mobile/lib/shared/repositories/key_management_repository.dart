import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/key_management_service.dart';

abstract class KeyManagementRepository {
  Future<KeyManagement> getById(String id);
  Future<List<KeyManagement>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<KeyManagement> create(KeyManagement item);
  Future<KeyManagement> update(String id, KeyManagement item);
  Future<void> delete(String id);
}

class KeyManagementRepositoryImpl implements KeyManagementRepository {
  final KeyManagementService _service;
  KeyManagementRepositoryImpl(this._service);

  @override
  Future<KeyManagement> getById(String id) => _service.getKeyManagementById(id);

  @override
  Future<List<KeyManagement>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getKeyManagements(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<KeyManagement> create(KeyManagement item) => _service.createKeyManagement(item);

  @override
  Future<KeyManagement> update(String id, KeyManagement item) => _service.updateKeyManagement(id, item);

  @override
  Future<void> delete(String id) => _service.deleteKeyManagement(id);
}
