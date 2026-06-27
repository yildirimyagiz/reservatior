import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class LocationService {
  final DioClient _dioClient;
  LocationService(this._dioClient);

  Future<Location> getLocationById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.locations}/$id');
    return Location.fromJson(response.data['data']);
  }

  Future<List<Location>> getLocations({
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
    final response = await _dioClient.get(ApiEndpoints.locations, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => Location.fromJson(json)).toList();
  }

  Future<Location> createLocation(Location item) async {
    final response = await _dioClient.post(ApiEndpoints.locations, data: item.toJson());
    return Location.fromJson(response.data['data']);
  }

  Future<Location> updateLocation(String id, Location item) async {
    final response = await _dioClient.patch('${ApiEndpoints.locations}/$id', data: item.toJson());
    return Location.fromJson(response.data['data']);
  }

  Future<void> deleteLocation(String id) async {
    await _dioClient.delete('${ApiEndpoints.locations}/$id');
  }
}
