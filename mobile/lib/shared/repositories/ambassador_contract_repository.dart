import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/ambassador_contract_service.dart';

abstract class AmbassadorContractRepository {
  Future<AmbassadorContract> getById(String id);
  Future<List<AmbassadorContract>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<AmbassadorContract> create(AmbassadorContract item);
  Future<AmbassadorContract> update(String id, AmbassadorContract item);
  Future<void> delete(String id);
}

class AmbassadorContractRepositoryImpl implements AmbassadorContractRepository {
  final AmbassadorContractService _service;
  AmbassadorContractRepositoryImpl(this._service);

  @override
  Future<AmbassadorContract> getById(String id) => _service.getAmbassadorContractById(id);

  @override
  Future<List<AmbassadorContract>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getAmbassadorContracts(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<AmbassadorContract> create(AmbassadorContract item) => _service.createAmbassadorContract(item);

  @override
  Future<AmbassadorContract> update(String id, AmbassadorContract item) => _service.updateAmbassadorContract(id, item);

  @override
  Future<void> delete(String id) => _service.deleteAmbassadorContract(id);
}
