import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class BookingService {
  final DioClient _dioClient;

  BookingService(this._dioClient);

  // Get Booking by ID
  Future<Booking> getBookingById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/booking/$id');
      return Booking.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all bookings
  Future<List<Booking>> getBookings({
    int page = 1,
    int limit = 20,
    Map<String, dynamic>? filters,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'page': page.toString(),
        'limit': limit.toString(),
      };

      if (filters != null) {
        queryParams.addAll(filters);
      }

      final response = await _dioClient.get('/api/v1/booking', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => Booking.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create Booking
  Future<Booking> createBooking(Booking booking) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/booking',
        data: booking.toJson(),
      );
      return Booking.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update Booking
  Future<Booking> updateBooking(String id, Booking booking) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/booking/$id',
        data: booking.toJson(),
      );
      return Booking.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete Booking
  Future<void> deleteBooking(String id) async {
    try {
      await _dioClient.delete('/api/v1/booking/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
