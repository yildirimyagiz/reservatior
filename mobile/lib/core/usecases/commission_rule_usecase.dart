import 'package:reservatior/shared/repositories/commission_rule_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetCommissionRuleByIdUseCase {
  final CommissionRuleRepository _repository;
  GetCommissionRuleByIdUseCase(this._repository);
  Future<CommissionRule> execute(String id) => _repository.getById(id);
}

class GetCommissionRulesUseCase {
  final CommissionRuleRepository _repository;
  GetCommissionRulesUseCase(this._repository);
  Future<List<CommissionRule>> execute({
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

class CreateCommissionRuleUseCase {
  final CommissionRuleRepository _repository;
  CreateCommissionRuleUseCase(this._repository);
  Future<CommissionRule> execute(CommissionRule item) => _repository.create(item);
}

class UpdateCommissionRuleUseCase {
  final CommissionRuleRepository _repository;
  UpdateCommissionRuleUseCase(this._repository);
  Future<CommissionRule> execute(String id, CommissionRule item) => _repository.update(id, item);
}

class DeleteCommissionRuleUseCase {
  final CommissionRuleRepository _repository;
  DeleteCommissionRuleUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
