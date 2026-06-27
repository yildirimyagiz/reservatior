import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class GuestProfileService {
  final DioClient _dioClient;
  GuestProfileService(this._dioClient);

  Future<GuestProfile> getGuestProfileById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.guestProfiles}/$id');
    return GuestProfile.fromJson(response.data['data']);
  }

  Future<List<GuestProfile>> getGuestProfiles({
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
    final response = await _dioClient.get(ApiEndpoints.guestProfiles, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => GuestProfile.fromJson(json)).toList();
  }

  Future<GuestProfile> createGuestProfile(GuestProfile item) async {
    final response = await _dioClient.post(ApiEndpoints.guestProfiles, data: item.toJson());
    return GuestProfile.fromJson(response.data['data']);
  }

  Future<GuestProfile> updateGuestProfile(String id, GuestProfile item) async {
    final response = await _dioClient.patch('${ApiEndpoints.guestProfiles}/$id', data: item.toJson());
    return GuestProfile.fromJson(response.data['data']);
  }

  Future<void> deleteGuestProfile(String id) async {
    await _dioClient.delete('${ApiEndpoints.guestProfiles}/$id');
  }
}
