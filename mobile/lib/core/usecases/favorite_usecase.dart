import '../../features/shared/services/favorite_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for Favorite

class GetFavoriteByIdUseCase {
  final FavoriteService _service;
  
  GetFavoriteByIdUseCase(this._service);
  
  Future<Favorite> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetFavoritesUseCase {
  final FavoriteService _service;
  
  GetFavoritesUseCase(this._service);
  
  Future<List<Favorite>> execute({
    int page = 1,
    int limit = 20,
    Map<String, dynamic>? filters,
  }) async {
    if (page <= 0) {
      throw ArgumentError('Page must be greater than 0');
    }
    if (limit <= 0 || limit > 100) {
      throw ArgumentError('Limit must be between 1 and 100');
    }
    return await _service.getAll(
      page: page,
      limit: limit,
      filters: filters,
    );
  }
}

class CreateFavoriteUseCase {
  final FavoriteService _service;
  
  CreateFavoriteUseCase(this._service);
  
  Future<Favorite> execute(Favorite favorite) async {
    // Add validation logic here
    return await _service.create(favorite);
  }
}

class UpdateFavoriteUseCase {
  final FavoriteService _service;
  
  UpdateFavoriteUseCase(this._service);
  
  Future<Favorite> execute(String id, Favorite favorite) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, favorite);
  }
}

class DeleteFavoriteUseCase {
  final FavoriteService _service;
  
  DeleteFavoriteUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// Favorite Use Case Container
class FavoriteUseCases {
  final GetFavoriteByIdUseCase getById;
  final GetFavoritesUseCase getAll;
  final CreateFavoriteUseCase create;
  final UpdateFavoriteUseCase update;
  final DeleteFavoriteUseCase delete;
  
  FavoriteUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory FavoriteUseCases.create(FavoriteService service) {
    return FavoriteUseCases(
      getById: GetFavoriteByIdUseCase(service),
      getAll: GetFavoritesUseCase(service),
      create: CreateFavoriteUseCase(service),
      update: UpdateFavoriteUseCase(service),
      delete: DeleteFavoriteUseCase(service),
    );
  }
}
