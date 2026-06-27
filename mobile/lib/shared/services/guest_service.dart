import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class GuestService {
  final DioClient _dioClient;
  GuestService(this._dioClient);

  Future<Guest> getGuestById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.guests}/$id');
    return Guest.fromJson(response.data['data']);
  }

  Future<List<Guest>> getGuests({
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
    final response = await _dioClient.get(ApiEndpoints.guests, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => Guest.fromJson(json)).toList();
  }

  Future<Guest> createGuest(Guest item) async {
    final response = await _dioClient.post(ApiEndpoints.guests, data: item.toJson());
    return Guest.fromJson(response.data['data']);
  }

  Future<Guest> updateGuest(String id, Guest item) async {
    final response = await _dioClient.patch('${ApiEndpoints.guests}/$id', data: item.toJson());
    return Guest.fromJson(response.data['data']);
  }

  Future<void> deleteGuest(String id) async {
    await _dioClient.delete('${ApiEndpoints.guests}/$id');
  }
}
