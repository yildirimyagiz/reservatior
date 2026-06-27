import 'package:reservatior/shared/repositories/pricing_rule_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetPricingRuleByIdUseCase {
  final PricingRuleRepository _repository;
  GetPricingRuleByIdUseCase(this._repository);
  Future<PricingRule> execute(String id) => _repository.getById(id);
}

class GetPricingRulesUseCase {
  final PricingRuleRepository _repository;
  GetPricingRulesUseCase(this._repository);
  Future<List<PricingRule>> execute({
    int page = 1, 
    int limit = 20, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) => _repository.getAll(
    page: page, 
    limit: limit, 
    filters: filters,
    sortBy: sortBy,
    sortOrder: sortOrder,
  );
}

class CreatePricingRuleUseCase {
  final PricingRuleRepository _repository;
  CreatePricingRuleUseCase(this._repository);
  Future<PricingRule> execute(PricingRule item) => _repository.create(item);
}

class UpdatePricingRuleUseCase {
  final PricingRuleRepository _repository;
  UpdatePricingRuleUseCase(this._repository);
  Future<PricingRule> execute(String id, PricingRule item) => _repository.update(id, item);
}

class DeletePricingRuleUseCase {
  final PricingRuleRepository _repository;
  DeletePricingRuleUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
