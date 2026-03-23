import '../../features/shared/services/tax_depreciation_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for TaxDepreciation

class GetTaxDepreciationByIdUseCase {
  final TaxDepreciationService _service;
  
  GetTaxDepreciationByIdUseCase(this._service);
  
  Future<TaxDepreciation> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetTaxDepreciationsUseCase {
  final TaxDepreciationService _service;
  
  GetTaxDepreciationsUseCase(this._service);
  
  Future<List<TaxDepreciation>> execute({
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

class CreateTaxDepreciationUseCase {
  final TaxDepreciationService _service;
  
  CreateTaxDepreciationUseCase(this._service);
  
  Future<TaxDepreciation> execute(TaxDepreciation taxDepreciation) async {
    // Add validation logic here
    return await _service.create(taxDepreciation);
  }
}

class UpdateTaxDepreciationUseCase {
  final TaxDepreciationService _service;
  
  UpdateTaxDepreciationUseCase(this._service);
  
  Future<TaxDepreciation> execute(String id, TaxDepreciation taxDepreciation) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, taxDepreciation);
  }
}

class DeleteTaxDepreciationUseCase {
  final TaxDepreciationService _service;
  
  DeleteTaxDepreciationUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// TaxDepreciation Use Case Container
class TaxDepreciationUseCases {
  final GetTaxDepreciationByIdUseCase getById;
  final GetTaxDepreciationsUseCase getAll;
  final CreateTaxDepreciationUseCase create;
  final UpdateTaxDepreciationUseCase update;
  final DeleteTaxDepreciationUseCase delete;
  
  TaxDepreciationUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory TaxDepreciationUseCases.create(TaxDepreciationService service) {
    return TaxDepreciationUseCases(
      getById: GetTaxDepreciationByIdUseCase(service),
      getAll: GetTaxDepreciationsUseCase(service),
      create: CreateTaxDepreciationUseCase(service),
      update: UpdateTaxDepreciationUseCase(service),
      delete: DeleteTaxDepreciationUseCase(service),
    );
  }
}
