import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/contract_version_service.dart';

abstract class ContractVersionRepository {
  Future<ContractVersion> getById(String id);
  Future<List<ContractVersion>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<ContractVersion> create(ContractVersion item);
  Future<ContractVersion> update(String id, ContractVersion item);
  Future<void> delete(String id);
}

class ContractVersionRepositoryImpl implements ContractVersionRepository {
  final ContractVersionService _service;
  ContractVersionRepositoryImpl(this._service);

  @override
  Future<ContractVersion> getById(String id) => _service.getContractVersionById(id);

  @override
  Future<List<ContractVersion>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getContractVersions(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<ContractVersion> create(ContractVersion item) => _service.createContractVersion(item);

  @override
  Future<ContractVersion> update(String id, ContractVersion item) => _service.updateContractVersion(id, item);

  @override
  Future<void> delete(String id) => _service.deleteContractVersion(id);
}
