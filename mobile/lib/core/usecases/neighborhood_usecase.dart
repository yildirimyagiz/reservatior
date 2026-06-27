import 'package:reservatior/shared/repositories/neighborhood_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetNeighborhoodByIdUseCase {
  final NeighborhoodRepository _repository;
  GetNeighborhoodByIdUseCase(this._repository);
  Future<Neighborhood> execute(String id) => _repository.getById(id);
}

class GetNeighborhoodsUseCase {
  final NeighborhoodRepository _repository;
  GetNeighborhoodsUseCase(this._repository);
  Future<List<Neighborhood>> execute({
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

class CreateNeighborhoodUseCase {
  final NeighborhoodRepository _repository;
  CreateNeighborhoodUseCase(this._repository);
  Future<Neighborhood> execute(Neighborhood item) => _repository.create(item);
}

class UpdateNeighborhoodUseCase {
  final NeighborhoodRepository _repository;
  UpdateNeighborhoodUseCase(this._repository);
  Future<Neighborhood> execute(String id, Neighborhood item) => _repository.update(id, item);
}

class DeleteNeighborhoodUseCase {
  final NeighborhoodRepository _repository;
  DeleteNeighborhoodUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
