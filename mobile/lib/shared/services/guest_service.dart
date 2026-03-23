import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class GuestService {
  final DioClient _dioClient;

  GuestService(this._dioClient);

  // Get Guest by ID
  Future<Guest> getGuestById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/guest/$id');
      return Guest.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all guests
  Future<List<Guest>> getGuests({
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

      final response = await _dioClient.get('/api/v1/guest', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => Guest.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create Guest
  Future<Guest> createGuest(Guest guest) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/guest',
        data: guest.toJson(),
      );
      return Guest.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update Guest
  Future<Guest> updateGuest(String id, Guest guest) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/guest/$id',
        data: guest.toJson(),
      );
      return Guest.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete Guest
  Future<void> deleteGuest(String id) async {
    try {
      await _dioClient.delete('/api/v1/guest/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
