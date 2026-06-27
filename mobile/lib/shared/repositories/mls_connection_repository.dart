import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/mls_connection_service.dart';

abstract class MlsConnectionRepository {
  Future<MlsConnection> getById(String id);
  Future<List<MlsConnection>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<MlsConnection> create(MlsConnection item);
  Future<MlsConnection> update(String id, MlsConnection item);
  Future<void> delete(String id);
}

class MlsConnectionRepositoryImpl implements MlsConnectionRepository {
  final MlsConnectionService _service;
  MlsConnectionRepositoryImpl(this._service);

  @override
  Future<MlsConnection> getById(String id) => _service.getMlsConnectionById(id);

  @override
  Future<List<MlsConnection>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getMlsConnections(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<MlsConnection> create(MlsConnection item) => _service.createMlsConnection(item);

  @override
  Future<MlsConnection> update(String id, MlsConnection item) => _service.updateMlsConnection(id, item);

  @override
  Future<void> delete(String id) => _service.deleteMlsConnection(id);
}
