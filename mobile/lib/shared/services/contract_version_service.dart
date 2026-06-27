import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class ContractVersionService {
  final DioClient _dioClient;
  ContractVersionService(this._dioClient);

  Future<ContractVersion> getContractVersionById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.contractVersions}/$id');
    return ContractVersion.fromJson(response.data['data']);
  }

  Future<List<ContractVersion>> getContractVersions({
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
    final response = await _dioClient.get(ApiEndpoints.contractVersions, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => ContractVersion.fromJson(json)).toList();
  }

  Future<ContractVersion> createContractVersion(ContractVersion item) async {
    final response = await _dioClient.post(ApiEndpoints.contractVersions, data: item.toJson());
    return ContractVersion.fromJson(response.data['data']);
  }

  Future<ContractVersion> updateContractVersion(String id, ContractVersion item) async {
    final response = await _dioClient.patch('${ApiEndpoints.contractVersions}/$id', data: item.toJson());
    return ContractVersion.fromJson(response.data['data']);
  }

  Future<void> deleteContractVersion(String id) async {
    await _dioClient.delete('${ApiEndpoints.contractVersions}/$id');
  }
}
