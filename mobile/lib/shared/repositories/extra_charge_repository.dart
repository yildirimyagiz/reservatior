import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/extra_charge_service.dart';

abstract class ExtraChargeRepository {
  Future<ExtraCharge> getById(String id);
  Future<List<ExtraCharge>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<ExtraCharge> create(ExtraCharge item);
  Future<ExtraCharge> update(String id, ExtraCharge item);
  Future<void> delete(String id);
}

class ExtraChargeRepositoryImpl implements ExtraChargeRepository {
  final ExtraChargeService _service;
  ExtraChargeRepositoryImpl(this._service);

  @override
  Future<ExtraCharge> getById(String id) => _service.getExtraChargeById(id);

  @override
  Future<List<ExtraCharge>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getExtraCharges(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<ExtraCharge> create(ExtraCharge item) => _service.createExtraCharge(item);

  @override
  Future<ExtraCharge> update(String id, ExtraCharge item) => _service.updateExtraCharge(id, item);

  @override
  Future<void> delete(String id) => _service.deleteExtraCharge(id);
}
