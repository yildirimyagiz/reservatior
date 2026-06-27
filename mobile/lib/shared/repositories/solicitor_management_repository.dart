import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/solicitor_management_service.dart';

abstract class SolicitorManagementRepository {
  Future<SolicitorManagement> getById(String id);
  Future<List<SolicitorManagement>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<SolicitorManagement> create(SolicitorManagement item);
  Future<SolicitorManagement> update(String id, SolicitorManagement item);
  Future<void> delete(String id);
}

class SolicitorManagementRepositoryImpl implements SolicitorManagementRepository {
  final SolicitorManagementService _service;
  SolicitorManagementRepositoryImpl(this._service);

  @override
  Future<SolicitorManagement> getById(String id) => _service.getSolicitorManagementById(id);

  @override
  Future<List<SolicitorManagement>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getSolicitorManagements(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<SolicitorManagement> create(SolicitorManagement item) => _service.createSolicitorManagement(item);

  @override
  Future<SolicitorManagement> update(String id, SolicitorManagement item) => _service.updateSolicitorManagement(id, item);

  @override
  Future<void> delete(String id) => _service.deleteSolicitorManagement(id);
}
