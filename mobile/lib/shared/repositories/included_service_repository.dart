import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/included_service_service.dart';

abstract class IncludedServiceRepository {
  Future<IncludedService> getById(String id);
  Future<List<IncludedService>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<IncludedService> create(IncludedService item);
  Future<IncludedService> update(String id, IncludedService item);
  Future<void> delete(String id);
}

class IncludedServiceRepositoryImpl implements IncludedServiceRepository {
  final IncludedServiceService _service;
  IncludedServiceRepositoryImpl(this._service);

  @override
  Future<IncludedService> getById(String id) => _service.getIncludedServiceById(id);

  @override
  Future<List<IncludedService>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getIncludedServices(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<IncludedService> create(IncludedService item) => _service.createIncludedService(item);

  @override
  Future<IncludedService> update(String id, IncludedService item) => _service.updateIncludedService(id, item);

  @override
  Future<void> delete(String id) => _service.deleteIncludedService(id);
}
