import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class FavoriteService {
  final DioClient _dioClient;
  FavoriteService(this._dioClient);

  Future<Favorite> getFavoriteById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.favorites}/$id');
    return Favorite.fromJson(response.data['data']);
  }

  Future<List<Favorite>> getFavorites({
    int page = 1, 
    int limit = 20, 
    String? orgId,
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) async {
    final queryParams = {
      'page': page, 
      'limit': limit,
      if (orgId != null) 'orgId': orgId,
      if (sortBy != null) 'sortBy': sortBy,
      if (sortOrder != null) 'sortOrder': sortOrder,
      ...?filters
    };
    final response = await _dioClient.get(ApiEndpoints.favorites, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => Favorite.fromJson(json)).toList();
  }

  Future<Favorite> createFavorite(Favorite item) async {
    final response = await _dioClient.post(ApiEndpoints.favorites, data: item.toJson());
    return Favorite.fromJson(response.data['data']);
  }

  Future<Favorite> updateFavorite(String id, Favorite item) async {
    final response = await _dioClient.patch('${ApiEndpoints.favorites}/$id', data: item.toJson());
    return Favorite.fromJson(response.data['data']);
  }

  Future<void> deleteFavorite(String id) async {
    await _dioClient.delete('${ApiEndpoints.favorites}/$id');
  }
}
