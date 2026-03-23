import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class LoyaltyAccountService {
  final DioClient _dioClient;

  LoyaltyAccountService(this._dioClient);

  // Get LoyaltyAccount by ID
  Future<LoyaltyAccount> getLoyaltyAccountById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/loyalty_account/$id');
      return LoyaltyAccount.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all loyalty_accounts
  Future<List<LoyaltyAccount>> getLoyaltyAccounts({
    int page = 1,
    int limit = 20,
    Map<String, dynamic>? filters,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'page': page.toString(),
        'limit': limit.toString(),
      };

      if (filters != null) {
        queryParams.addAll(filters);
      }

      final response = await _dioClient.get('/api/v1/loyalty_account', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => LoyaltyAccount.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create LoyaltyAccount
  Future<LoyaltyAccount> createLoyaltyAccount(LoyaltyAccount loyaltyAccount) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/loyalty_account',
        data: loyaltyAccount.toJson(),
      );
      return LoyaltyAccount.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update LoyaltyAccount
  Future<LoyaltyAccount> updateLoyaltyAccount(String id, LoyaltyAccount loyaltyAccount) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/loyalty_account/$id',
        data: loyaltyAccount.toJson(),
      );
      return LoyaltyAccount.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete LoyaltyAccount
  Future<void> deleteLoyaltyAccount(String id) async {
    try {
      await _dioClient.delete('/api/v1/loyalty_account/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
