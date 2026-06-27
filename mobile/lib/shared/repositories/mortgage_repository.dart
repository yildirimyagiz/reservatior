import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/mortgage_service.dart';

abstract class MortgageRepository {
  Future<Mortgage> getById(String id);
  Future<List<Mortgage>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<Mortgage> create(Mortgage item);
  Future<Mortgage> update(String id, Mortgage item);
  Future<void> delete(String id);
}

class MortgageRepositoryImpl implements MortgageRepository {
  final MortgageService _service;
  MortgageRepositoryImpl(this._service);

  @override
  Future<Mortgage> getById(String id) => _service.getMortgageById(id);

  @override
  Future<List<Mortgage>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getMortgages(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<Mortgage> create(Mortgage item) => _service.createMortgage(item);

  @override
  Future<Mortgage> update(String id, Mortgage item) => _service.updateMortgage(id, item);

  @override
  Future<void> delete(String id) => _service.deleteMortgage(id);
}
