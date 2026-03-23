import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class HashtagService {
  final DioClient _dioClient;

  HashtagService(this._dioClient);

  // Get Hashtag by ID
  Future<Hashtag> getHashtagById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/hashtag/$id');
      return Hashtag.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all hashtags
  Future<List<Hashtag>> getHashtags({
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

      final response = await _dioClient.get('/api/v1/hashtag', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => Hashtag.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create Hashtag
  Future<Hashtag> createHashtag(Hashtag hashtag) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/hashtag',
        data: hashtag.toJson(),
      );
      return Hashtag.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update Hashtag
  Future<Hashtag> updateHashtag(String id, Hashtag hashtag) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/hashtag/$id',
        data: hashtag.toJson(),
      );
      return Hashtag.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete Hashtag
  Future<void> deleteHashtag(String id) async {
    try {
      await _dioClient.delete('/api/v1/hashtag/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
