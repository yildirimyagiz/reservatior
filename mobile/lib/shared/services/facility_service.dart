import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class FacilityService {
  final DioClient _dioClient;
  FacilityService(this._dioClient);

  Future<Facility> getFacilityById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.facilities}/$id');
    return Facility.fromJson(response.data['data']);
  }

  Future<List<Facility>> getFacilities({
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
    final response = await _dioClient.get(ApiEndpoints.facilities, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => Facility.fromJson(json)).toList();
  }

  Future<Facility> createFacility(Facility item) async {
    final response = await _dioClient.post(ApiEndpoints.facilities, data: item.toJson());
    return Facility.fromJson(response.data['data']);
  }

  Future<Facility> updateFacility(String id, Facility item) async {
    final response = await _dioClient.patch('${ApiEndpoints.facilities}/$id', data: item.toJson());
    return Facility.fromJson(response.data['data']);
  }

  Future<void> deleteFacility(String id) async {
    await _dioClient.delete('${ApiEndpoints.facilities}/$id');
  }
}
