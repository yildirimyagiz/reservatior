import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/rent_arrears_service.dart';

abstract class RentArrearsRepository {
  Future<RentArrears> getById(String id);
  Future<List<RentArrears>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<RentArrears> create(RentArrears item);
  Future<RentArrears> update(String id, RentArrears item);
  Future<void> delete(String id);
}

class RentArrearsRepositoryImpl implements RentArrearsRepository {
  final RentArrearsService _service;
  RentArrearsRepositoryImpl(this._service);

  @override
  Future<RentArrears> getById(String id) => _service.getRentArrearsById(id);

  @override
  Future<List<RentArrears>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getRentArrearses(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<RentArrears> create(RentArrears item) => _service.createRentArrears(item);

  @override
  Future<RentArrears> update(String id, RentArrears item) => _service.updateRentArrears(id, item);

  @override
  Future<void> delete(String id) => _service.deleteRentArrears(id);
}
