import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/repository_exception.dart';

/// Repository for Booking operations
/// Provides CRUD operations with proper error handling and type safety
class BookingRepository {
  final DioClient _dioClient;

  BookingRepository(this._dioClient);

  /// Get Booking by ID
  /// Returns [Booking] if found, throws [RepositoryException] otherwise
  Future<Booking> getBookingById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/booking/$id');
      if (response.statusCode == 200) {
        return Booking.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to fetch booking',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.notFound,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all bookings with pagination and filtering
  /// Returns list of [Booking] objects
  Future<List<Booking>> getbookings({
    int page = 1,
    int limit = 20,
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'page': page,
        'limit': limit,
        if (sortBy != null) 'sort_by': sortBy,
        if (sortOrder != null) 'sort_order': sortOrder,
        ...?filters,
      };
      
      final response = await _dioClient.get('/api/v1/booking', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => Booking.fromJson(item)).toList();
      } else {
        throw RepositoryException(
          message: 'Failed to fetch bookings',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new Booking
  /// Returns created [Booking] object
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
    // Implement error handling logic here
    return Exception('API Error: ${e.message}');
  }
}
