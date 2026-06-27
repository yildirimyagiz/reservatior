import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/tax_depreciation_service.dart';

abstract class TaxDepreciationRepository {
  Future<TaxDepreciation> getById(String id);
  Future<List<TaxDepreciation>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<TaxDepreciation> create(TaxDepreciation item);
  Future<TaxDepreciation> update(String id, TaxDepreciation item);
  Future<void> delete(String id);
}

class TaxDepreciationRepositoryImpl implements TaxDepreciationRepository {
  final TaxDepreciationService _service;
  TaxDepreciationRepositoryImpl(this._service);

  @override
  Future<TaxDepreciation> getById(String id) => _service.getTaxDepreciationById(id);

  @override
  Future<List<TaxDepreciation>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getTaxDepreciations(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<TaxDepreciation> create(TaxDepreciation item) => _service.createTaxDepreciation(item);

  @override
  Future<TaxDepreciation> update(String id, TaxDepreciation item) => _service.updateTaxDepreciation(id, item);

  @override
  Future<void> delete(String id) => _service.deleteTaxDepreciation(id);
}
