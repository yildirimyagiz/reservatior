import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/pricing_rule_service.dart';

abstract class PricingRuleRepository {
  Future<PricingRule> getById(String id);
  Future<List<PricingRule>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<PricingRule> create(PricingRule item);
  Future<PricingRule> update(String id, PricingRule item);
  Future<void> delete(String id);
}

class PricingRuleRepositoryImpl implements PricingRuleRepository {
  final PricingRuleService _service;
  PricingRuleRepositoryImpl(this._service);

  @override
  Future<PricingRule> getById(String id) => _service.getPricingRuleById(id);

  @override
  Future<List<PricingRule>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getPricingRules(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<PricingRule> create(PricingRule item) => _service.createPricingRule(item);

  @override
  Future<PricingRule> update(String id, PricingRule item) => _service.updatePricingRule(id, item);

  @override
  Future<void> delete(String id) => _service.deletePricingRule(id);
}
