import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/maintenance_block_service.dart';

abstract class MaintenanceBlockRepository {
  Future<MaintenanceBlock> getById(String id);
  Future<List<MaintenanceBlock>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<MaintenanceBlock> create(MaintenanceBlock item);
  Future<MaintenanceBlock> update(String id, MaintenanceBlock item);
  Future<void> delete(String id);
}

class MaintenanceBlockRepositoryImpl implements MaintenanceBlockRepository {
  final MaintenanceBlockService _service;
  MaintenanceBlockRepositoryImpl(this._service);

  @override
  Future<MaintenanceBlock> getById(String id) => _service.getMaintenanceBlockById(id);

  @override
  Future<List<MaintenanceBlock>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getMaintenanceBlocks(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<MaintenanceBlock> create(MaintenanceBlock item) => _service.createMaintenanceBlock(item);

  @override
  Future<MaintenanceBlock> update(String id, MaintenanceBlock item) => _service.updateMaintenanceBlock(id, item);

  @override
  Future<void> delete(String id) => _service.deleteMaintenanceBlock(id);
}
