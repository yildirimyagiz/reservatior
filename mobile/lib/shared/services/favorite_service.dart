import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class FavoriteService {
  final DioClient _dioClient;

  FavoriteService(this._dioClient);

  // Get Favorite by ID
  Future<Favorite> getFavoriteById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/favorite/$id');
      return Favorite.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all favorites
  Future<List<Favorite>> getFavorites({
    int page = 1,
    int limit = 20,
    Map<String, dynamic>? filters,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'page': page.toString(),
        'limit': limit.toString(),
      };

      if (filters != null) {
        queryParams.addAll(filters);
      }

      final response = await _dioClient.get('/api/v1/favorite', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => Favorite.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create Favorite
  Future<Favorite> createFavorite(Favorite favorite) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/favorite',
        data: favorite.toJson(),
      );
      return Favorite.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update Favorite
  Future<Favorite> updateFavorite(String id, Favorite favorite) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/favorite/$id',
        data: favorite.toJson(),
      );
      return Favorite.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete Favorite
  Future<void> deleteFavorite(String id) async {
    try {
      await _dioClient.delete('/api/v1/favorite/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
