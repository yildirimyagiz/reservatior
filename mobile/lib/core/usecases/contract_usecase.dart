import 'package:reservatior/shared/repositories/contract_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetContractByIdUseCase {
  final ContractRepository _repository;
  GetContractByIdUseCase(this._repository);
  Future<Contract> execute(String id) => _repository.getById(id);
}

class GetContractsUseCase {
  final ContractRepository _repository;
  GetContractsUseCase(this._repository);
  Future<List<Contract>> execute({
    int page = 1, 
    int limit = 20, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) => _repository.getAll(
    page: page, 
    limit: limit, 
    filters: filters,
    sortBy: sortBy,
    sortOrder: sortOrder,
  );
}

class CreateContractUseCase {
  final ContractRepository _repository;
  CreateContractUseCase(this._repository);
  Future<Contract> execute(Contract item) => _repository.create(item);
}

class UpdateContractUseCase {
  final ContractRepository _repository;
  UpdateContractUseCase(this._repository);
  Future<Contract> execute(String id, Contract item) => _repository.update(id, item);
}

class DeleteContractUseCase {
  final ContractRepository _repository;
  DeleteContractUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
