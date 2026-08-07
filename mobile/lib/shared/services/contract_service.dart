import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class ContractService {
  final DioClient _dioClient;
  ContractService(this._dioClient);

  Future<Contract> getContractById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.contracts}/$id');
    return Contract.fromJson(response.data['data']);
  }

  Future<List<Contract>> getContracts({
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
    final response = await _dioClient.get(ApiEndpoints.contracts, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => Contract.fromJson(json)).toList();
  }

  Future<Contract> createContract(Contract item) async {
    final response = await _dioClient.post(ApiEndpoints.contracts, data: item.toJson());
    return Contract.fromJson(response.data['data']);
  }

  Future<Contract> updateContract(String id, Contract item) async {
    final response = await _dioClient.patch('${ApiEndpoints.contracts}/$id', data: item.toJson());
    return Contract.fromJson(response.data['data']);
  }

  Future<void> deleteContract(String id) async {
    await _dioClient.delete('${ApiEndpoints.contracts}/$id');
  }

  /// Fetch the full contract template catalog (countries, types, languages).
  Future<Map<String, dynamic>> getContractTemplates() async {
    final response = await _dioClient.get(ApiEndpoints.contractTemplates);
    return Map<String, dynamic>.from(response.data['data'] ?? {});
  }

  /// Generate a localized contract via the server Contract Engine.
  Future<Map<String, dynamic>> generateContract({
    required String type,
    required String region,
    String? language,
    required Map<String, dynamic> data,
    bool persist = false,
  }) async {
    final response = await _dioClient.post(
      ApiEndpoints.contractGenerate,
      data: {
        'type': type,
        'region': region,
        if (language != null) 'language': language,
        'data': data,
        'persist': persist,
      },
    );
    return Map<String, dynamic>.from(response.data ?? {});
  }
}
