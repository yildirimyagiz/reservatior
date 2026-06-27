import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/right_to_rent_check_service.dart';

abstract class RightToRentCheckRepository {
  Future<RightToRentCheck> getById(String id);
  Future<List<RightToRentCheck>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<RightToRentCheck> create(RightToRentCheck item);
  Future<RightToRentCheck> update(String id, RightToRentCheck item);
  Future<void> delete(String id);
}

class RightToRentCheckRepositoryImpl implements RightToRentCheckRepository {
  final RightToRentCheckService _service;
  RightToRentCheckRepositoryImpl(this._service);

  @override
  Future<RightToRentCheck> getById(String id) => _service.getRightToRentCheckById(id);

  @override
  Future<List<RightToRentCheck>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getRightToRentChecks(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<RightToRentCheck> create(RightToRentCheck item) => _service.createRightToRentCheck(item);

  @override
  Future<RightToRentCheck> update(String id, RightToRentCheck item) => _service.updateRightToRentCheck(id, item);

  @override
  Future<void> delete(String id) => _service.deleteRightToRentCheck(id);
}
