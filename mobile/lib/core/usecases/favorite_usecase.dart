import 'package:reservatior/shared/repositories/favorite_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetFavoriteByIdUseCase {
  final FavoriteRepository _repository;
  GetFavoriteByIdUseCase(this._repository);
  Future<Favorite> execute(String id) => _repository.getById(id);
}

class GetFavoritesUseCase {
  final FavoriteRepository _repository;
  GetFavoritesUseCase(this._repository);
  Future<List<Favorite>> execute({
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

class CreateFavoriteUseCase {
  final FavoriteRepository _repository;
  CreateFavoriteUseCase(this._repository);
  Future<Favorite> execute(Favorite item) => _repository.create(item);
}

class UpdateFavoriteUseCase {
  final FavoriteRepository _repository;
  UpdateFavoriteUseCase(this._repository);
  Future<Favorite> execute(String id, Favorite item) => _repository.update(id, item);
}

class DeleteFavoriteUseCase {
  final FavoriteRepository _repository;
  DeleteFavoriteUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
