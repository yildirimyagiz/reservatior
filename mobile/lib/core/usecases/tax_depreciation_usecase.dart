import 'package:reservatior/shared/repositories/tax_depreciation_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetTaxDepreciationByIdUseCase {
  final TaxDepreciationRepository _repository;
  GetTaxDepreciationByIdUseCase(this._repository);
  Future<TaxDepreciation> execute(String id) => _repository.getById(id);
}

class GetTaxDepreciationsUseCase {
  final TaxDepreciationRepository _repository;
  GetTaxDepreciationsUseCase(this._repository);
  Future<List<TaxDepreciation>> execute({
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

class CreateTaxDepreciationUseCase {
  final TaxDepreciationRepository _repository;
  CreateTaxDepreciationUseCase(this._repository);
  Future<TaxDepreciation> execute(TaxDepreciation item) => _repository.create(item);
}

class UpdateTaxDepreciationUseCase {
  final TaxDepreciationRepository _repository;
  UpdateTaxDepreciationUseCase(this._repository);
  Future<TaxDepreciation> execute(String id, TaxDepreciation item) => _repository.update(id, item);
}

class DeleteTaxDepreciationUseCase {
  final TaxDepreciationRepository _repository;
  DeleteTaxDepreciationUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
