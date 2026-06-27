import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/booking_service.dart';

abstract class BookingRepository {
  Future<Booking> getById(String id);
  Future<List<Booking>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<Booking> create(Booking item);
  Future<Booking> update(String id, Booking item);
  Future<void> delete(String id);
  Future<Map<String, dynamic>> createGuestReview(String id, Map<String, dynamic> item);
}

class BookingRepositoryImpl implements BookingRepository {
  final BookingService _service;
  BookingRepositoryImpl(this._service);

  @override
  Future<Booking> getById(String id) => _service.getBookingById(id);

  @override
  Future<List<Booking>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getBookings(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<Booking> create(Booking item) => _service.createBooking(item);

  @override
  Future<Booking> update(String id, Booking item) => _service.updateBooking(id, item);

  @override
  Future<void> delete(String id) => _service.deleteBooking(id);

  @override
  Future<Map<String, dynamic>> createGuestReview(String id, Map<String, dynamic> item) => _service.createGuestReview(id, item);
}
