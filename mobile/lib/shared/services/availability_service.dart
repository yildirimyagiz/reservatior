import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class AvailabilityService {
  final DioClient _dioClient;
  AvailabilityService(this._dioClient);

  Future<Availability> getAvailabilityById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.availabilities}/$id');
    return Availability.fromJson(response.data['data']);
  }

  Future<List<Availability>> getAvailabilities({
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
    final response = await _dioClient.get(ApiEndpoints.availabilities, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => Availability.fromJson(json)).toList();
  }

  Future<Availability> createAvailability(Availability item) async {
    final response = await _dioClient.post(ApiEndpoints.availabilities, data: item.toJson());
    return Availability.fromJson(response.data['data']);
  }

  Future<Availability> updateAvailability(String id, Availability item) async {
    final response = await _dioClient.patch('${ApiEndpoints.availabilities}/$id', data: item.toJson());
    return Availability.fromJson(response.data['data']);
  }

  Future<void> deleteAvailability(String id) async {
    await _dioClient.delete('${ApiEndpoints.availabilities}/$id');
  }
}
