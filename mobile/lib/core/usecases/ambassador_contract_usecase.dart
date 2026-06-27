import 'package:reservatior/shared/repositories/ambassador_contract_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetAmbassadorContractByIdUseCase {
  final AmbassadorContractRepository _repository;
  GetAmbassadorContractByIdUseCase(this._repository);
  Future<AmbassadorContract> execute(String id) => _repository.getById(id);
}

class GetAmbassadorContractsUseCase {
  final AmbassadorContractRepository _repository;
  GetAmbassadorContractsUseCase(this._repository);
  Future<List<AmbassadorContract>> execute({
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

class CreateAmbassadorContractUseCase {
  final AmbassadorContractRepository _repository;
  CreateAmbassadorContractUseCase(this._repository);
  Future<AmbassadorContract> execute(AmbassadorContract item) => _repository.create(item);
}

class UpdateAmbassadorContractUseCase {
  final AmbassadorContractRepository _repository;
  UpdateAmbassadorContractUseCase(this._repository);
  Future<AmbassadorContract> execute(String id, AmbassadorContract item) => _repository.update(id, item);
}

class DeleteAmbassadorContractUseCase {
  final AmbassadorContractRepository _repository;
  DeleteAmbassadorContractUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
