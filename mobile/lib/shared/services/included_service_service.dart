import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class IncludedServiceService {
  final DioClient _dioClient;
  IncludedServiceService(this._dioClient);

  Future<IncludedService> getIncludedServiceById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.includedServices}/$id');
    return IncludedService.fromJson(response.data['data']);
  }

  Future<List<IncludedService>> getIncludedServices({
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
    final response = await _dioClient.get(ApiEndpoints.includedServices, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => IncludedService.fromJson(json)).toList();
  }

  Future<IncludedService> createIncludedService(IncludedService item) async {
    final response = await _dioClient.post(ApiEndpoints.includedServices, data: item.toJson());
    return IncludedService.fromJson(response.data['data']);
  }

  Future<IncludedService> updateIncludedService(String id, IncludedService item) async {
    final response = await _dioClient.patch('${ApiEndpoints.includedServices}/$id', data: item.toJson());
    return IncludedService.fromJson(response.data['data']);
  }

  Future<void> deleteIncludedService(String id) async {
    await _dioClient.delete('${ApiEndpoints.includedServices}/$id');
  }
}
