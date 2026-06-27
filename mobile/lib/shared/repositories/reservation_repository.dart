import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/reservation_service.dart';

abstract class ReservationRepository {
  Future<Reservation> getById(String id);
  Future<List<Reservation>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<Reservation> create(Reservation item);
  Future<Reservation> update(String id, Reservation item);
  Future<void> delete(String id);
}

class ReservationRepositoryImpl implements ReservationRepository {
  final ReservationService _service;
  ReservationRepositoryImpl(this._service);

  @override
  Future<Reservation> getById(String id) => _service.getReservationById(id);

  @override
  Future<List<Reservation>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getReservations(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<Reservation> create(Reservation item) => _service.createReservation(item);

  @override
  Future<Reservation> update(String id, Reservation item) => _service.updateReservation(id, item);

  @override
  Future<void> delete(String id) => _service.deleteReservation(id);
}
