import 'package:reservatior/shared/repositories/increase_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetIncreaseByIdUseCase {
  final IncreaseRepository _repository;
  GetIncreaseByIdUseCase(this._repository);
  Future<Increase> execute(String id) => _repository.getById(id);
}

class GetIncreasesUseCase {
  final IncreaseRepository _repository;
  GetIncreasesUseCase(this._repository);
  Future<List<Increase>> execute({
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

class CreateIncreaseUseCase {
  final IncreaseRepository _repository;
  CreateIncreaseUseCase(this._repository);
  Future<Increase> execute(Increase item) => _repository.create(item);
}

class UpdateIncreaseUseCase {
  final IncreaseRepository _repository;
  UpdateIncreaseUseCase(this._repository);
  Future<Increase> execute(String id, Increase item) => _repository.update(id, item);
}

class DeleteIncreaseUseCase {
  final IncreaseRepository _repository;
  DeleteIncreaseUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
