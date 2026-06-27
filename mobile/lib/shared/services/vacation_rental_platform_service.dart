import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class VacationRentalPlatformService {
  final DioClient _dioClient;
  VacationRentalPlatformService(this._dioClient);

  Future<VacationRentalPlatform> getVacationRentalPlatformById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.vacationRentalPlatforms}/$id');
    return VacationRentalPlatform.fromJson(response.data['data']);
  }

  Future<List<VacationRentalPlatform>> getVacationRentalPlatforms({
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
    final response = await _dioClient.get(ApiEndpoints.vacationRentalPlatforms, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => VacationRentalPlatform.fromJson(json)).toList();
  }

  Future<VacationRentalPlatform> createVacationRentalPlatform(VacationRentalPlatform item) async {
    final response = await _dioClient.post(ApiEndpoints.vacationRentalPlatforms, data: item.toJson());
    return VacationRentalPlatform.fromJson(response.data['data']);
  }

  Future<VacationRentalPlatform> updateVacationRentalPlatform(String id, VacationRentalPlatform item) async {
    final response = await _dioClient.patch('${ApiEndpoints.vacationRentalPlatforms}/$id', data: item.toJson());
    return VacationRentalPlatform.fromJson(response.data['data']);
  }

  Future<void> deleteVacationRentalPlatform(String id) async {
    await _dioClient.delete('${ApiEndpoints.vacationRentalPlatforms}/$id');
  }
}
