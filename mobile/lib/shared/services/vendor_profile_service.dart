import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class VendorProfileService {
  final DioClient _dioClient;
  VendorProfileService(this._dioClient);

  Future<VendorProfile> getVendorProfileById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.vendorProfiles}/$id');
    return VendorProfile.fromJson(response.data['data']);
  }

  Future<List<VendorProfile>> getVendorProfiles({
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
    final response = await _dioClient.get(ApiEndpoints.vendorProfiles, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => VendorProfile.fromJson(json)).toList();
  }

  Future<VendorProfile> createVendorProfile(VendorProfile item) async {
    final response = await _dioClient.post(ApiEndpoints.vendorProfiles, data: item.toJson());
    return VendorProfile.fromJson(response.data['data']);
  }

  Future<VendorProfile> updateVendorProfile(String id, VendorProfile item) async {
    final response = await _dioClient.patch('${ApiEndpoints.vendorProfiles}/$id', data: item.toJson());
    return VendorProfile.fromJson(response.data['data']);
  }

  Future<void> deleteVendorProfile(String id) async {
    await _dioClient.delete('${ApiEndpoints.vendorProfiles}/$id');
  }
}
