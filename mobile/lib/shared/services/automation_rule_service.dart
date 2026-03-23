import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class AutomationRuleService {
  final DioClient _dioClient;

  AutomationRuleService(this._dioClient);

  // Get AutomationRule by ID
  Future<AutomationRule> getAutomationRuleById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/automation_rule/$id');
      return AutomationRule.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all automation_rules
  Future<List<AutomationRule>> getAutomationRules({
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

      final response = await _dioClient.get('/api/v1/automation_rule', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => AutomationRule.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create AutomationRule
  Future<AutomationRule> createAutomationRule(AutomationRule automationRule) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/automation_rule',
        data: automationRule.toJson(),
      );
      return AutomationRule.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update AutomationRule
  Future<AutomationRule> updateAutomationRule(String id, AutomationRule automationRule) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/automation_rule/$id',
        data: automationRule.toJson(),
      );
      return AutomationRule.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete AutomationRule
  Future<void> deleteAutomationRule(String id) async {
    try {
      await _dioClient.delete('/api/v1/automation_rule/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
