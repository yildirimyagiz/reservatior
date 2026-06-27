import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class AttorneyManagementService {
  final DioClient _dioClient;
  AttorneyManagementService(this._dioClient);

  Future<AttorneyManagement> getAttorneyManagementById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.attorneyManagements}/$id');
    return AttorneyManagement.fromJson(response.data['data']);
  }

  Future<List<AttorneyManagement>> getAttorneyManagements({
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
    final response = await _dioClient.get(ApiEndpoints.attorneyManagements, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => AttorneyManagement.fromJson(json)).toList();
  }

  Future<AttorneyManagement> createAttorneyManagement(AttorneyManagement item) async {
    final response = await _dioClient.post(ApiEndpoints.attorneyManagements, data: item.toJson());
    return AttorneyManagement.fromJson(response.data['data']);
  }

  Future<AttorneyManagement> updateAttorneyManagement(String id, AttorneyManagement item) async {
    final response = await _dioClient.patch('${ApiEndpoints.attorneyManagements}/$id', data: item.toJson());
    return AttorneyManagement.fromJson(response.data['data']);
  }

  Future<void> deleteAttorneyManagement(String id) async {
    await _dioClient.delete('${ApiEndpoints.attorneyManagements}/$id');
  }
}
