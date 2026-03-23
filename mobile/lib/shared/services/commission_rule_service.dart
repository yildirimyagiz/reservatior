import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class CommissionRuleService {
  final DioClient _dioClient;

  CommissionRuleService(this._dioClient);

  // Get CommissionRule by ID
  Future<CommissionRule> getCommissionRuleById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/commission_rule/$id');
      return CommissionRule.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all commission_rules
  Future<List<CommissionRule>> getCommissionRules({
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

      final response = await _dioClient.get('/api/v1/commission_rule', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => CommissionRule.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create CommissionRule
  Future<CommissionRule> createCommissionRule(CommissionRule commissionRule) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/commission_rule',
        data: commissionRule.toJson(),
      );
      return CommissionRule.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update CommissionRule
  Future<CommissionRule> updateCommissionRule(String id, CommissionRule commissionRule) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/commission_rule/$id',
        data: commissionRule.toJson(),
      );
      return CommissionRule.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete CommissionRule
  Future<void> deleteCommissionRule(String id) async {
    try {
      await _dioClient.delete('/api/v1/commission_rule/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
