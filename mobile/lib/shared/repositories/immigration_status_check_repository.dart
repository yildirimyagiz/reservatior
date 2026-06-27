import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/immigration_status_check_service.dart';

abstract class ImmigrationStatusCheckRepository {
  Future<ImmigrationStatusCheck> getById(String id);
  Future<List<ImmigrationStatusCheck>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<ImmigrationStatusCheck> create(ImmigrationStatusCheck item);
  Future<ImmigrationStatusCheck> update(String id, ImmigrationStatusCheck item);
  Future<void> delete(String id);
}

class ImmigrationStatusCheckRepositoryImpl implements ImmigrationStatusCheckRepository {
  final ImmigrationStatusCheckService _service;
  ImmigrationStatusCheckRepositoryImpl(this._service);

  @override
  Future<ImmigrationStatusCheck> getById(String id) => _service.getImmigrationStatusCheckById(id);

  @override
  Future<List<ImmigrationStatusCheck>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getImmigrationStatusChecks(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<ImmigrationStatusCheck> create(ImmigrationStatusCheck item) => _service.createImmigrationStatusCheck(item);

  @override
  Future<ImmigrationStatusCheck> update(String id, ImmigrationStatusCheck item) => _service.updateImmigrationStatusCheck(id, item);

  @override
  Future<void> delete(String id) => _service.deleteImmigrationStatusCheck(id);
}
