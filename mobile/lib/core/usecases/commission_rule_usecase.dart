import '../../features/shared/services/commission_rule_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for CommissionRule

class GetCommissionRuleByIdUseCase {
  final CommissionRuleService _service;
  
  GetCommissionRuleByIdUseCase(this._service);
  
  Future<CommissionRule> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetCommissionRulesUseCase {
  final CommissionRuleService _service;
  
  GetCommissionRulesUseCase(this._service);
  
  Future<List<CommissionRule>> execute({
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

class CreateCommissionRuleUseCase {
  final CommissionRuleService _service;
  
  CreateCommissionRuleUseCase(this._service);
  
  Future<CommissionRule> execute(CommissionRule commissionRule) async {
    // Add validation logic here
    return await _service.create(commissionRule);
  }
}

class UpdateCommissionRuleUseCase {
  final CommissionRuleService _service;
  
  UpdateCommissionRuleUseCase(this._service);
  
  Future<CommissionRule> execute(String id, CommissionRule commissionRule) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, commissionRule);
  }
}

class DeleteCommissionRuleUseCase {
  final CommissionRuleService _service;
  
  DeleteCommissionRuleUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// CommissionRule Use Case Container
class CommissionRuleUseCases {
  final GetCommissionRuleByIdUseCase getById;
  final GetCommissionRulesUseCase getAll;
  final CreateCommissionRuleUseCase create;
  final UpdateCommissionRuleUseCase update;
  final DeleteCommissionRuleUseCase delete;
  
  CommissionRuleUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory CommissionRuleUseCases.create(CommissionRuleService service) {
    return CommissionRuleUseCases(
      getById: GetCommissionRuleByIdUseCase(service),
      getAll: GetCommissionRulesUseCase(service),
      create: CreateCommissionRuleUseCase(service),
      update: UpdateCommissionRuleUseCase(service),
      delete: DeleteCommissionRuleUseCase(service),
    );
  }
}
