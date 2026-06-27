import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class AmbassadorContractService {
  final DioClient _dioClient;
  AmbassadorContractService(this._dioClient);

  Future<AmbassadorContract> getAmbassadorContractById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.ambassadorContracts}/$id');
    return AmbassadorContract.fromJson(response.data['data']);
  }

  Future<List<AmbassadorContract>> getAmbassadorContracts({
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
    final response = await _dioClient.get(ApiEndpoints.ambassadorContracts, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => AmbassadorContract.fromJson(json)).toList();
  }

  Future<AmbassadorContract> createAmbassadorContract(AmbassadorContract item) async {
    final response = await _dioClient.post(ApiEndpoints.ambassadorContracts, data: item.toJson());
    return AmbassadorContract.fromJson(response.data['data']);
  }

  Future<AmbassadorContract> updateAmbassadorContract(String id, AmbassadorContract item) async {
    final response = await _dioClient.patch('${ApiEndpoints.ambassadorContracts}/$id', data: item.toJson());
    return AmbassadorContract.fromJson(response.data['data']);
  }

  Future<void> deleteAmbassadorContract(String id) async {
    await _dioClient.delete('${ApiEndpoints.ambassadorContracts}/$id');
  }
}
