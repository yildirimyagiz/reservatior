import 'package:reservatior/shared/repositories/mortgage_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetMortgageByIdUseCase {
  final MortgageRepository _repository;
  GetMortgageByIdUseCase(this._repository);
  Future<Mortgage> execute(String id) => _repository.getById(id);
}

class GetMortgagesUseCase {
  final MortgageRepository _repository;
  GetMortgagesUseCase(this._repository);
  Future<List<Mortgage>> execute({
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

class CreateMortgageUseCase {
  final MortgageRepository _repository;
  CreateMortgageUseCase(this._repository);
  Future<Mortgage> execute(Mortgage item) => _repository.create(item);
}

class UpdateMortgageUseCase {
  final MortgageRepository _repository;
  UpdateMortgageUseCase(this._repository);
  Future<Mortgage> execute(String id, Mortgage item) => _repository.update(id, item);
}

class DeleteMortgageUseCase {
  final MortgageRepository _repository;
  DeleteMortgageUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
