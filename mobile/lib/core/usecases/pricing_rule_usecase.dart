import '../../features/shared/services/pricing_rule_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for PricingRule

class GetPricingRuleByIdUseCase {
  final PricingRuleService _service;
  
  GetPricingRuleByIdUseCase(this._service);
  
  Future<PricingRule> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetPricingRulesUseCase {
  final PricingRuleService _service;
  
  GetPricingRulesUseCase(this._service);
  
  Future<List<PricingRule>> execute({
    int page = 1,
    int limit = 20,
    Map<String, dynamic>? filters,
  }) async {
    if (page <= 0) {
      throw ArgumentError('Page must be greater than 0');
    }
    if (limit <= 0 || limit > 100) {
      throw ArgumentError('Limit must be between 1 and 100');
    }
    return await _service.getAll(
      page: page,
      limit: limit,
      filters: filters,
    );
  }
}

class CreatePricingRuleUseCase {
  final PricingRuleService _service;
  
  CreatePricingRuleUseCase(this._service);
  
  Future<PricingRule> execute(PricingRule pricingRule) async {
    // Add validation logic here
    return await _service.create(pricingRule);
  }
}

class UpdatePricingRuleUseCase {
  final PricingRuleService _service;
  
  UpdatePricingRuleUseCase(this._service);
  
  Future<PricingRule> execute(String id, PricingRule pricingRule) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, pricingRule);
  }
}

class DeletePricingRuleUseCase {
  final PricingRuleService _service;
  
  DeletePricingRuleUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// PricingRule Use Case Container
class PricingRuleUseCases {
  final GetPricingRuleByIdUseCase getById;
  final GetPricingRulesUseCase getAll;
  final CreatePricingRuleUseCase create;
  final UpdatePricingRuleUseCase update;
  final DeletePricingRuleUseCase delete;
  
  PricingRuleUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory PricingRuleUseCases.create(PricingRuleService service) {
    return PricingRuleUseCases(
      getById: GetPricingRuleByIdUseCase(service),
      getAll: GetPricingRulesUseCase(service),
      create: CreatePricingRuleUseCase(service),
      update: UpdatePricingRuleUseCase(service),
      delete: DeletePricingRuleUseCase(service),
    );
  }
}
