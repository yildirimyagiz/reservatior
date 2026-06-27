import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/vacation_rental_service.dart';

abstract class VacationRentalRepository {
  Future<VacationRental> getById(String id);
  Future<List<VacationRental>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<VacationRental> create(VacationRental item);
  Future<VacationRental> update(String id, VacationRental item);
  Future<void> delete(String id);
}

class VacationRentalRepositoryImpl implements VacationRentalRepository {
  final VacationRentalService _service;
  VacationRentalRepositoryImpl(this._service);

  @override
  Future<VacationRental> getById(String id) => _service.getVacationRentalById(id);

  @override
  Future<List<VacationRental>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getVacationRentals(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<VacationRental> create(VacationRental item) => _service.createVacationRental(item);

  @override
  Future<VacationRental> update(String id, VacationRental item) => _service.updateVacationRental(id, item);

  @override
  Future<void> delete(String id) => _service.deleteVacationRental(id);
}
