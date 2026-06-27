import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/commission_rule_service.dart';

abstract class CommissionRuleRepository {
  Future<CommissionRule> getById(String id);
  Future<List<CommissionRule>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<CommissionRule> create(CommissionRule item);
  Future<CommissionRule> update(String id, CommissionRule item);
  Future<void> delete(String id);
}

class CommissionRuleRepositoryImpl implements CommissionRuleRepository {
  final CommissionRuleService _service;
  CommissionRuleRepositoryImpl(this._service);

  @override
  Future<CommissionRule> getById(String id) => _service.getCommissionRuleById(id);

  @override
  Future<List<CommissionRule>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getCommissionRules(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<CommissionRule> create(CommissionRule item) => _service.createCommissionRule(item);

  @override
  Future<CommissionRule> update(String id, CommissionRule item) => _service.updateCommissionRule(id, item);

  @override
  Future<void> delete(String id) => _service.deleteCommissionRule(id);
}
