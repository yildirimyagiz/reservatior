import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class PricingRuleService {
  final DioClient _dioClient;

  PricingRuleService(this._dioClient);

  // Get PricingRule by ID
  Future<PricingRule> getPricingRuleById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/pricing_rule/$id');
      return PricingRule.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all pricing_rules
  Future<List<PricingRule>> getPricingRules({
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

      final response = await _dioClient.get('/api/v1/pricing_rule', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => PricingRule.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create PricingRule
  Future<PricingRule> createPricingRule(PricingRule pricingRule) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/pricing_rule',
        data: pricingRule.toJson(),
      );
      return PricingRule.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update PricingRule
  Future<PricingRule> updatePricingRule(String id, PricingRule pricingRule) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/pricing_rule/$id',
        data: pricingRule.toJson(),
      );
      return PricingRule.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete PricingRule
  Future<void> deletePricingRule(String id) async {
    try {
      await _dioClient.delete('/api/v1/pricing_rule/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
