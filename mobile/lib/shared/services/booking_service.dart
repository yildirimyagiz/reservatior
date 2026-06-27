import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class BookingService {
  final DioClient _dioClient;
  BookingService(this._dioClient);

  Future<Booking> getBookingById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.bookings}/$id');
    return Booking.fromJson(response.data['data']);
  }

  Future<List<Booking>> getBookings({
    int page = 1, 
    int limit = 20, 
    String? orgId,
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) async {
    final queryParams = {
      'page': page, 
      'limit': limit,
      if (orgId != null) 'orgId': orgId,
      if (sortBy != null) 'sortBy': sortBy,
      if (sortOrder != null) 'sortOrder': sortOrder,
      ...?filters
    };
    final response = await _dioClient.get(ApiEndpoints.bookings, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => Booking.fromJson(json)).toList();
  }

  Future<Booking> createBooking(Booking item) async {
    final response = await _dioClient.post(ApiEndpoints.bookings, data: item.toJson());
    return Booking.fromJson(response.data['data']);
  }

  Future<Booking> updateBooking(String id, Booking item) async {
    final response = await _dioClient.patch('${ApiEndpoints.bookings}/$id', data: item.toJson());
    return Booking.fromJson(response.data['data']);
  }

  Future<void> deleteBooking(String id) async {
    await _dioClient.delete('${ApiEndpoints.bookings}/$id');
  }

  Future<Map<String, dynamic>> createGuestReview(String id, Map<String, dynamic> item) async {
    final response = await _dioClient.post('${ApiEndpoints.bookings}/$id/guest-review', data: item);
    return response.data['data'];
  }
}
