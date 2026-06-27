import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/investor_property_service.dart';

abstract class InvestorPropertyRepository {
  Future<InvestorProperty> getById(String id);
  Future<List<InvestorProperty>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<InvestorProperty> create(InvestorProperty item);
  Future<InvestorProperty> update(String id, InvestorProperty item);
  Future<void> delete(String id);
}

class InvestorPropertyRepositoryImpl implements InvestorPropertyRepository {
  final InvestorPropertyService _service;
  InvestorPropertyRepositoryImpl(this._service);

  @override
  Future<InvestorProperty> getById(String id) => _service.getInvestorPropertyById(id);

  @override
  Future<List<InvestorProperty>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getInvestorProperties(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<InvestorProperty> create(InvestorProperty item) => _service.createInvestorProperty(item);

  @override
  Future<InvestorProperty> update(String id, InvestorProperty item) => _service.updateInvestorProperty(id, item);

  @override
  Future<void> delete(String id) => _service.deleteInvestorProperty(id);
}
