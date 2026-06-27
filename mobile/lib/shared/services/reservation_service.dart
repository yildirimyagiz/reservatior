import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class ReservationService {
  final DioClient _dioClient;
  ReservationService(this._dioClient);

  Future<Reservation> getReservationById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.reservations}/$id');
    return Reservation.fromJson(response.data['data']);
  }

  Future<List<Reservation>> getReservations({
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
    final response = await _dioClient.get(ApiEndpoints.reservations, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => Reservation.fromJson(json)).toList();
  }

  Future<Reservation> createReservation(Reservation item) async {
    final response = await _dioClient.post(ApiEndpoints.reservations, data: item.toJson());
    return Reservation.fromJson(response.data['data']);
  }

  Future<Reservation> updateReservation(String id, Reservation item) async {
    final response = await _dioClient.patch('${ApiEndpoints.reservations}/$id', data: item.toJson());
    return Reservation.fromJson(response.data['data']);
  }

  Future<void> deleteReservation(String id) async {
    await _dioClient.delete('${ApiEndpoints.reservations}/$id');
  }
}
