import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class LoyaltyAccountService {
  final DioClient _dioClient;
  LoyaltyAccountService(this._dioClient);

  Future<LoyaltyAccount> getLoyaltyAccountById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.loyaltyAccounts}/$id');
    return LoyaltyAccount.fromJson(response.data['data']);
  }

  Future<List<LoyaltyAccount>> getLoyaltyAccounts({
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
    final response = await _dioClient.get(ApiEndpoints.loyaltyAccounts, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => LoyaltyAccount.fromJson(json)).toList();
  }

  Future<LoyaltyAccount> createLoyaltyAccount(LoyaltyAccount item) async {
    final response = await _dioClient.post(ApiEndpoints.loyaltyAccounts, data: item.toJson());
    return LoyaltyAccount.fromJson(response.data['data']);
  }

  Future<LoyaltyAccount> updateLoyaltyAccount(String id, LoyaltyAccount item) async {
    final response = await _dioClient.patch('${ApiEndpoints.loyaltyAccounts}/$id', data: item.toJson());
    return LoyaltyAccount.fromJson(response.data['data']);
  }

  Future<void> deleteLoyaltyAccount(String id) async {
    await _dioClient.delete('${ApiEndpoints.loyaltyAccounts}/$id');
  }
}
