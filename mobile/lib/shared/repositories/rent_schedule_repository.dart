import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/rent_schedule_service.dart';

abstract class RentScheduleRepository {
  Future<RentSchedule> getById(String id);
  Future<List<RentSchedule>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<RentSchedule> create(RentSchedule item);
  Future<RentSchedule> update(String id, RentSchedule item);
  Future<void> delete(String id);
}

class RentScheduleRepositoryImpl implements RentScheduleRepository {
  final RentScheduleService _service;
  RentScheduleRepositoryImpl(this._service);

  @override
  Future<RentSchedule> getById(String id) => _service.getRentScheduleById(id);

  @override
  Future<List<RentSchedule>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getRentSchedules(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<RentSchedule> create(RentSchedule item) => _service.createRentSchedule(item);

  @override
  Future<RentSchedule> update(String id, RentSchedule item) => _service.updateRentSchedule(id, item);

  @override
  Future<void> delete(String id) => _service.deleteRentSchedule(id);
}
