import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/increase_service.dart';

abstract class IncreaseRepository {
  Future<Increase> getById(String id);
  Future<List<Increase>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<Increase> create(Increase item);
  Future<Increase> update(String id, Increase item);
  Future<void> delete(String id);
}

class IncreaseRepositoryImpl implements IncreaseRepository {
  final IncreaseService _service;
  IncreaseRepositoryImpl(this._service);

  @override
  Future<Increase> getById(String id) => _service.getIncreaseById(id);

  @override
  Future<List<Increase>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getIncreases(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<Increase> create(Increase item) => _service.createIncrease(item);

  @override
  Future<Increase> update(String id, Increase item) => _service.updateIncrease(id, item);

  @override
  Future<void> delete(String id) => _service.deleteIncrease(id);
}
