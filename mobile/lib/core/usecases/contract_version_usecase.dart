import 'package:reservatior/shared/repositories/contract_version_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetContractVersionByIdUseCase {
  final ContractVersionRepository _repository;
  GetContractVersionByIdUseCase(this._repository);
  Future<ContractVersion> execute(String id) => _repository.getById(id);
}

class GetContractVersionsUseCase {
  final ContractVersionRepository _repository;
  GetContractVersionsUseCase(this._repository);
  Future<List<ContractVersion>> execute({
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

class CreateContractVersionUseCase {
  final ContractVersionRepository _repository;
  CreateContractVersionUseCase(this._repository);
  Future<ContractVersion> execute(ContractVersion item) => _repository.create(item);
}

class UpdateContractVersionUseCase {
  final ContractVersionRepository _repository;
  UpdateContractVersionUseCase(this._repository);
  Future<ContractVersion> execute(String id, ContractVersion item) => _repository.update(id, item);
}

class DeleteContractVersionUseCase {
  final ContractVersionRepository _repository;
  DeleteContractVersionUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
