import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/favorite_service.dart';

abstract class FavoriteRepository {
  Future<Favorite> getById(String id);
  Future<List<Favorite>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<Favorite> create(Favorite item);
  Future<Favorite> update(String id, Favorite item);
  Future<void> delete(String id);
}

class FavoriteRepositoryImpl implements FavoriteRepository {
  final FavoriteService _service;
  FavoriteRepositoryImpl(this._service);

  @override
  Future<Favorite> getById(String id) => _service.getFavoriteById(id);

  @override
  Future<List<Favorite>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getFavorites(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<Favorite> create(Favorite item) => _service.createFavorite(item);

  @override
  Future<Favorite> update(String id, Favorite item) => _service.updateFavorite(id, item);

  @override
  Future<void> delete(String id) => _service.deleteFavorite(id);
}
