import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/repository_exception.dart';

/// Repository for Reservation operations
/// Provides CRUD operations with proper error handling and type safety
class ReservationRepository {
  final DioClient _dioClient;

  ReservationRepository(this._dioClient);

  /// Get Reservation by ID
  /// Returns [Reservation] if found, throws [RepositoryException] otherwise
  Future<Reservation> getReservationById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/reservation/$id');
      if (response.statusCode == 200) {
        return Reservation.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to fetch reservation',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.notFound,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all reservations with pagination and filtering
  /// Returns list of [Reservation] objects
  Future<List<Reservation>> getreservations({
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
      
      final response = await _dioClient.get('/api/v1/reservation', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => Reservation.fromJson(item)).toList();
      } else {
        throw RepositoryException(
          message: 'Failed to fetch reservations',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new Reservation
  /// Returns created [Reservation] object
  Future<Reservation> createReservation(Reservation reservation) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/reservation',
        data: reservation.toJson(),
      );
      return Reservation.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update Reservation
  Future<Reservation> updateReservation(String id, Reservation reservation) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/reservation/$id',
        data: reservation.toJson(),
      );
      return Reservation.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete Reservation
  Future<void> deleteReservation(String id) async {
    try {
      await _dioClient.delete('/api/v1/reservation/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    // Implement error handling logic here
    return Exception('API Error: ${e.message}');
  }
}
