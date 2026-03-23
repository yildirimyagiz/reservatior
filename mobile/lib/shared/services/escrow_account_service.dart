import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class EscrowAccountService {
  final DioClient _dioClient;

  EscrowAccountService(this._dioClient);

  // Get EscrowAccount by ID
  Future<EscrowAccount> getEscrowAccountById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/escrow_account/$id');
      return EscrowAccount.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all escrow_accounts
  Future<List<EscrowAccount>> getEscrowAccounts({
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

      final response = await _dioClient.get('/api/v1/escrow_account', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => EscrowAccount.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create EscrowAccount
  Future<EscrowAccount> createEscrowAccount(EscrowAccount escrowAccount) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/escrow_account',
        data: escrowAccount.toJson(),
      );
      return EscrowAccount.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update EscrowAccount
  Future<EscrowAccount> updateEscrowAccount(String id, EscrowAccount escrowAccount) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/escrow_account/$id',
        data: escrowAccount.toJson(),
      );
      return EscrowAccount.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete EscrowAccount
  Future<void> deleteEscrowAccount(String id) async {
    try {
      await _dioClient.delete('/api/v1/escrow_account/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
