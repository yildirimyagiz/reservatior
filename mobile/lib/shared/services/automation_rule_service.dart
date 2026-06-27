import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class AutomationRuleService {
  final DioClient _dioClient;
  AutomationRuleService(this._dioClient);

  Future<AutomationRule> getAutomationRuleById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.automationRules}/$id');
    return AutomationRule.fromJson(response.data['data']);
  }

  Future<List<AutomationRule>> getAutomationRules({
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
    final response = await _dioClient.get(ApiEndpoints.automationRules, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => AutomationRule.fromJson(json)).toList();
  }

  Future<AutomationRule> createAutomationRule(AutomationRule item) async {
    final response = await _dioClient.post(ApiEndpoints.automationRules, data: item.toJson());
    return AutomationRule.fromJson(response.data['data']);
  }

  Future<AutomationRule> updateAutomationRule(String id, AutomationRule item) async {
    final response = await _dioClient.patch('${ApiEndpoints.automationRules}/$id', data: item.toJson());
    return AutomationRule.fromJson(response.data['data']);
  }

  Future<void> deleteAutomationRule(String id) async {
    await _dioClient.delete('${ApiEndpoints.automationRules}/$id');
  }
}
