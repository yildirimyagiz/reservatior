import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/brand_ambassador_service.dart';

abstract class BrandAmbassadorRepository {
  Future<BrandAmbassador> getById(String id);
  Future<List<BrandAmbassador>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<BrandAmbassador> create(BrandAmbassador item);
  Future<BrandAmbassador> update(String id, BrandAmbassador item);
  Future<void> delete(String id);
}

class BrandAmbassadorRepositoryImpl implements BrandAmbassadorRepository {
  final BrandAmbassadorService _service;
  BrandAmbassadorRepositoryImpl(this._service);

  @override
  Future<BrandAmbassador> getById(String id) => _service.getBrandAmbassadorById(id);

  @override
  Future<List<BrandAmbassador>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getBrandAmbassadors(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<BrandAmbassador> create(BrandAmbassador item) => _service.createBrandAmbassador(item);

  @override
  Future<BrandAmbassador> update(String id, BrandAmbassador item) => _service.updateBrandAmbassador(id, item);

  @override
  Future<void> delete(String id) => _service.deleteBrandAmbassador(id);
}
