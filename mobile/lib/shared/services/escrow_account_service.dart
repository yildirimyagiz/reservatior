import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class EscrowAccountService {
  final DioClient _dioClient;
  EscrowAccountService(this._dioClient);

  Future<EscrowAccount> getEscrowAccountById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.escrowAccounts}/$id');
    return EscrowAccount.fromJson(response.data['data']);
  }

  Future<List<EscrowAccount>> getEscrowAccounts({
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
    final response = await _dioClient.get(ApiEndpoints.escrowAccounts, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => EscrowAccount.fromJson(json)).toList();
  }

  Future<EscrowAccount> createEscrowAccount(EscrowAccount item) async {
    final response = await _dioClient.post(ApiEndpoints.escrowAccounts, data: item.toJson());
    return EscrowAccount.fromJson(response.data['data']);
  }

  Future<EscrowAccount> updateEscrowAccount(String id, EscrowAccount item) async {
    final response = await _dioClient.patch('${ApiEndpoints.escrowAccounts}/$id', data: item.toJson());
    return EscrowAccount.fromJson(response.data['data']);
  }

  Future<void> deleteEscrowAccount(String id) async {
    await _dioClient.delete('${ApiEndpoints.escrowAccounts}/$id');
  }
}
