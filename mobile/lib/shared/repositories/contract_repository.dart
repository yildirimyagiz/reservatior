import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/contract_service.dart';

abstract class ContractRepository {
  Future<Contract> getById(String id);
  Future<List<Contract>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<Contract> create(Contract item);
  Future<Contract> update(String id, Contract item);
  Future<void> delete(String id);
}

class ContractRepositoryImpl implements ContractRepository {
  final ContractService _service;
  ContractRepositoryImpl(this._service);

  @override
  Future<Contract> getById(String id) => _service.getContractById(id);

  @override
  Future<List<Contract>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getContracts(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<Contract> create(Contract item) => _service.createContract(item);

  @override
  Future<Contract> update(String id, Contract item) => _service.updateContract(id, item);

  @override
  Future<void> delete(String id) => _service.deleteContract(id);
}
