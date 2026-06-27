import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class AccountService {
  final DioClient _dioClient;
  AccountService(this._dioClient);

  Future<Account> getAccountById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.accounts}/$id');
    return Account.fromJson(response.data['data']);
  }

  Future<List<Account>> getAccounts({
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
    final response = await _dioClient.get(ApiEndpoints.accounts, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => Account.fromJson(json)).toList();
  }

  Future<Account> createAccount(Account item) async {
    final response = await _dioClient.post(ApiEndpoints.accounts, data: item.toJson());
    return Account.fromJson(response.data['data']);
  }

  Future<Account> updateAccount(String id, Account item) async {
    final response = await _dioClient.patch('${ApiEndpoints.accounts}/$id', data: item.toJson());
    return Account.fromJson(response.data['data']);
  }

  Future<void> deleteAccount(String id) async {
    await _dioClient.delete('${ApiEndpoints.accounts}/$id');
  }
}
