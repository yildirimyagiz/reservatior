import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class PricingRuleService {
  final DioClient _dioClient;
  PricingRuleService(this._dioClient);

  Future<PricingRule> getPricingRuleById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.pricingRules}/$id');
    return PricingRule.fromJson(response.data['data']);
  }

  Future<List<PricingRule>> getPricingRules({
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
    final response = await _dioClient.get(ApiEndpoints.pricingRules, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => PricingRule.fromJson(json)).toList();
  }

  Future<PricingRule> createPricingRule(PricingRule item) async {
    final response = await _dioClient.post(ApiEndpoints.pricingRules, data: item.toJson());
    return PricingRule.fromJson(response.data['data']);
  }

  Future<PricingRule> updatePricingRule(String id, PricingRule item) async {
    final response = await _dioClient.patch('${ApiEndpoints.pricingRules}/$id', data: item.toJson());
    return PricingRule.fromJson(response.data['data']);
  }

  Future<void> deletePricingRule(String id) async {
    await _dioClient.delete('${ApiEndpoints.pricingRules}/$id');
  }
}
