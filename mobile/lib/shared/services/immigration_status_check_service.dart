import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class ImmigrationStatusCheckService {
  final DioClient _dioClient;
  ImmigrationStatusCheckService(this._dioClient);

  Future<ImmigrationStatusCheck> getImmigrationStatusCheckById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.immigrationStatusChecks}/$id');
    return ImmigrationStatusCheck.fromJson(response.data['data']);
  }

  Future<List<ImmigrationStatusCheck>> getImmigrationStatusChecks({
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
    final response = await _dioClient.get(ApiEndpoints.immigrationStatusChecks, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => ImmigrationStatusCheck.fromJson(json)).toList();
  }

  Future<ImmigrationStatusCheck> createImmigrationStatusCheck(ImmigrationStatusCheck item) async {
    final response = await _dioClient.post(ApiEndpoints.immigrationStatusChecks, data: item.toJson());
    return ImmigrationStatusCheck.fromJson(response.data['data']);
  }

  Future<ImmigrationStatusCheck> updateImmigrationStatusCheck(String id, ImmigrationStatusCheck item) async {
    final response = await _dioClient.patch('${ApiEndpoints.immigrationStatusChecks}/$id', data: item.toJson());
    return ImmigrationStatusCheck.fromJson(response.data['data']);
  }

  Future<void> deleteImmigrationStatusCheck(String id) async {
    await _dioClient.delete('${ApiEndpoints.immigrationStatusChecks}/$id');
  }
}
