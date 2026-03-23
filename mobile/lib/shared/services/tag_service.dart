import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class TagService {
  final DioClient _dioClient;

  TagService(this._dioClient);

  // Get Tag by ID
  Future<Tag> getTagById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/tag/$id');
      return Tag.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all tags
  Future<List<Tag>> getTags({
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

      final response = await _dioClient.get('/api/v1/tag', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => Tag.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create Tag
  Future<Tag> createTag(Tag tag) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/tag',
        data: tag.toJson(),
      );
      return Tag.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update Tag
  Future<Tag> updateTag(String id, Tag tag) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/tag/$id',
        data: tag.toJson(),
      );
      return Tag.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete Tag
  Future<void> deleteTag(String id) async {
    try {
      await _dioClient.delete('/api/v1/tag/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
