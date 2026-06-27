import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/earning_service.dart';

abstract class EarningRepository {
  Future<Earning> getById(String id);
  Future<List<Earning>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<Earning> create(Earning item);
  Future<Earning> update(String id, Earning item);
  Future<void> delete(String id);
}

class EarningRepositoryImpl implements EarningRepository {
  final EarningService _service;
  EarningRepositoryImpl(this._service);

  @override
  Future<Earning> getById(String id) => _service.getEarningById(id);

  @override
  Future<List<Earning>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getEarnings(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<Earning> create(Earning item) => _service.createEarning(item);

  @override
  Future<Earning> update(String id, Earning item) => _service.updateEarning(id, item);

  @override
  Future<void> delete(String id) => _service.deleteEarning(id);
}
