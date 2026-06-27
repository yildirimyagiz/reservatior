import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class CommissionRuleService {
  final DioClient _dioClient;
  CommissionRuleService(this._dioClient);

  Future<CommissionRule> getCommissionRuleById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.commissionRules}/$id');
    return CommissionRule.fromJson(response.data['data']);
  }

  Future<List<CommissionRule>> getCommissionRules({
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
    final response = await _dioClient.get(ApiEndpoints.commissionRules, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => CommissionRule.fromJson(json)).toList();
  }

  Future<CommissionRule> createCommissionRule(CommissionRule item) async {
    final response = await _dioClient.post(ApiEndpoints.commissionRules, data: item.toJson());
    return CommissionRule.fromJson(response.data['data']);
  }

  Future<CommissionRule> updateCommissionRule(String id, CommissionRule item) async {
    final response = await _dioClient.patch('${ApiEndpoints.commissionRules}/$id', data: item.toJson());
    return CommissionRule.fromJson(response.data['data']);
  }

  Future<void> deleteCommissionRule(String id) async {
    await _dioClient.delete('${ApiEndpoints.commissionRules}/$id');
  }
}
