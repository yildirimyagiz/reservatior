import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class SharedAmenityService {
  final DioClient _dioClient;
  SharedAmenityService(this._dioClient);

  Future<SharedAmenity> getSharedAmenityById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.sharedAmenities}/$id');
    return SharedAmenity.fromJson(response.data['data']);
  }

  Future<List<SharedAmenity>> getSharedAmenities({
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
    final response = await _dioClient.get(ApiEndpoints.sharedAmenities, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => SharedAmenity.fromJson(json)).toList();
  }

  Future<SharedAmenity> createSharedAmenity(SharedAmenity item) async {
    final response = await _dioClient.post(ApiEndpoints.sharedAmenities, data: item.toJson());
    return SharedAmenity.fromJson(response.data['data']);
  }

  Future<SharedAmenity> updateSharedAmenity(String id, SharedAmenity item) async {
    final response = await _dioClient.patch('${ApiEndpoints.sharedAmenities}/$id', data: item.toJson());
    return SharedAmenity.fromJson(response.data['data']);
  }

  Future<void> deleteSharedAmenity(String id) async {
    await _dioClient.delete('${ApiEndpoints.sharedAmenities}/$id');
  }
}
