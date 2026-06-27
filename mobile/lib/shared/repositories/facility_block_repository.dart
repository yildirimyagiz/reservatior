import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/facility_block_service.dart';

abstract class FacilityBlockRepository {
  Future<FacilityBlock> getById(String id);
  Future<List<FacilityBlock>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<FacilityBlock> create(FacilityBlock item);
  Future<FacilityBlock> update(String id, FacilityBlock item);
  Future<void> delete(String id);
}

class FacilityBlockRepositoryImpl implements FacilityBlockRepository {
  final FacilityBlockService _service;
  FacilityBlockRepositoryImpl(this._service);

  @override
  Future<FacilityBlock> getById(String id) => _service.getFacilityBlockById(id);

  @override
  Future<List<FacilityBlock>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getFacilityBlocks(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<FacilityBlock> create(FacilityBlock item) => _service.createFacilityBlock(item);

  @override
  Future<FacilityBlock> update(String id, FacilityBlock item) => _service.updateFacilityBlock(id, item);

  @override
  Future<void> delete(String id) => _service.deleteFacilityBlock(id);
}
