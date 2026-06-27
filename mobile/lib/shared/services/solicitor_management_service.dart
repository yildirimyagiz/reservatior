import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class SolicitorManagementService {
  final DioClient _dioClient;
  SolicitorManagementService(this._dioClient);

  Future<SolicitorManagement> getSolicitorManagementById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.solicitorManagements}/$id');
    return SolicitorManagement.fromJson(response.data['data']);
  }

  Future<List<SolicitorManagement>> getSolicitorManagements({
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
    final response = await _dioClient.get(ApiEndpoints.solicitorManagements, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => SolicitorManagement.fromJson(json)).toList();
  }

  Future<SolicitorManagement> createSolicitorManagement(SolicitorManagement item) async {
    final response = await _dioClient.post(ApiEndpoints.solicitorManagements, data: item.toJson());
    return SolicitorManagement.fromJson(response.data['data']);
  }

  Future<SolicitorManagement> updateSolicitorManagement(String id, SolicitorManagement item) async {
    final response = await _dioClient.patch('${ApiEndpoints.solicitorManagements}/$id', data: item.toJson());
    return SolicitorManagement.fromJson(response.data['data']);
  }

  Future<void> deleteSolicitorManagement(String id) async {
    await _dioClient.delete('${ApiEndpoints.solicitorManagements}/$id');
  }
}
