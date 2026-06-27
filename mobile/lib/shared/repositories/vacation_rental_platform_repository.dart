import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/vacation_rental_platform_service.dart';

abstract class VacationRentalPlatformRepository {
  Future<VacationRentalPlatform> getById(String id);
  Future<List<VacationRentalPlatform>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<VacationRentalPlatform> create(VacationRentalPlatform item);
  Future<VacationRentalPlatform> update(String id, VacationRentalPlatform item);
  Future<void> delete(String id);
}

class VacationRentalPlatformRepositoryImpl implements VacationRentalPlatformRepository {
  final VacationRentalPlatformService _service;
  VacationRentalPlatformRepositoryImpl(this._service);

  @override
  Future<VacationRentalPlatform> getById(String id) => _service.getVacationRentalPlatformById(id);

  @override
  Future<List<VacationRentalPlatform>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getVacationRentalPlatforms(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<VacationRentalPlatform> create(VacationRentalPlatform item) => _service.createVacationRentalPlatform(item);

  @override
  Future<VacationRentalPlatform> update(String id, VacationRentalPlatform item) => _service.updateVacationRentalPlatform(id, item);

  @override
  Future<void> delete(String id) => _service.deleteVacationRentalPlatform(id);
}
