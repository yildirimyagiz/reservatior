import 'package:reservatior/shared/repositories/investor_property_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetInvestorPropertyByIdUseCase {
  final InvestorPropertyRepository _repository;
  GetInvestorPropertyByIdUseCase(this._repository);
  Future<InvestorProperty> execute(String id) => _repository.getById(id);
}

class GetInvestorPropertysUseCase {
  final InvestorPropertyRepository _repository;
  GetInvestorPropertysUseCase(this._repository);
  Future<List<InvestorProperty>> execute({
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

class CreateInvestorPropertyUseCase {
  final InvestorPropertyRepository _repository;
  CreateInvestorPropertyUseCase(this._repository);
  Future<InvestorProperty> execute(InvestorProperty item) => _repository.create(item);
}

class UpdateInvestorPropertyUseCase {
  final InvestorPropertyRepository _repository;
  UpdateInvestorPropertyUseCase(this._repository);
  Future<InvestorProperty> execute(String id, InvestorProperty item) => _repository.update(id, item);
}

class DeleteInvestorPropertyUseCase {
  final InvestorPropertyRepository _repository;
  DeleteInvestorPropertyUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
