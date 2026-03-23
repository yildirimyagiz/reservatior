import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class ReservationService {
  final DioClient _dioClient;

  ReservationService(this._dioClient);

  // Get Reservation by ID
  Future<Reservation> getReservationById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/reservation/$id');
      return Reservation.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all reservations
  Future<List<Reservation>> getReservations({
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

      final response = await _dioClient.get('/api/v1/reservation', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => Reservation.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create Reservation
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
    return Exception('API Error: ${e.message}');
  }
}
