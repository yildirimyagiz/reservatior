import 'package:reservatior/shared/repositories/earning_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetEarningByIdUseCase {
  final EarningRepository _repository;
  GetEarningByIdUseCase(this._repository);
  Future<Earning> execute(String id) => _repository.getById(id);
}

class GetEarningsUseCase {
  final EarningRepository _repository;
  GetEarningsUseCase(this._repository);
  Future<List<Earning>> execute({
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

class CreateEarningUseCase {
  final EarningRepository _repository;
  CreateEarningUseCase(this._repository);
  Future<Earning> execute(Earning item) => _repository.create(item);
}

class UpdateEarningUseCase {
  final EarningRepository _repository;
  UpdateEarningUseCase(this._repository);
  Future<Earning> execute(String id, Earning item) => _repository.update(id, item);
}

class DeleteEarningUseCase {
  final EarningRepository _repository;
  DeleteEarningUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
