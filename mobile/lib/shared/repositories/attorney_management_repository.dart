import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/attorney_management_service.dart';

abstract class AttorneyManagementRepository {
  Future<AttorneyManagement> getById(String id);
  Future<List<AttorneyManagement>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<AttorneyManagement> create(AttorneyManagement item);
  Future<AttorneyManagement> update(String id, AttorneyManagement item);
  Future<void> delete(String id);
}

class AttorneyManagementRepositoryImpl implements AttorneyManagementRepository {
  final AttorneyManagementService _service;
  AttorneyManagementRepositoryImpl(this._service);

  @override
  Future<AttorneyManagement> getById(String id) => _service.getAttorneyManagementById(id);

  @override
  Future<List<AttorneyManagement>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getAttorneyManagements(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<AttorneyManagement> create(AttorneyManagement item) => _service.createAttorneyManagement(item);

  @override
  Future<AttorneyManagement> update(String id, AttorneyManagement item) => _service.updateAttorneyManagement(id, item);

  @override
  Future<void> delete(String id) => _service.deleteAttorneyManagement(id);
}
