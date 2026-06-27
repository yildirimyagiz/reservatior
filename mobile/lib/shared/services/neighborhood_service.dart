import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class NeighborhoodService {
  final DioClient _dioClient;
  NeighborhoodService(this._dioClient);

  Future<Neighborhood> getNeighborhoodById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.neighborhoods}/$id');
    return Neighborhood.fromJson(response.data['data']);
  }

  Future<List<Neighborhood>> getNeighborhoods({
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
    final response = await _dioClient.get(ApiEndpoints.neighborhoods, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => Neighborhood.fromJson(json)).toList();
  }

  Future<Neighborhood> createNeighborhood(Neighborhood item) async {
    final response = await _dioClient.post(ApiEndpoints.neighborhoods, data: item.toJson());
    return Neighborhood.fromJson(response.data['data']);
  }

  Future<Neighborhood> updateNeighborhood(String id, Neighborhood item) async {
    final response = await _dioClient.patch('${ApiEndpoints.neighborhoods}/$id', data: item.toJson());
    return Neighborhood.fromJson(response.data['data']);
  }

  Future<void> deleteNeighborhood(String id) async {
    await _dioClient.delete('${ApiEndpoints.neighborhoods}/$id');
  }
}
