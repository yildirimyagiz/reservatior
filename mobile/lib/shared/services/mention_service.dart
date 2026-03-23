import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class MentionService {
  final DioClient _dioClient;

  MentionService(this._dioClient);

  // Get Mention by ID
  Future<Mention> getMentionById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/mention/$id');
      return Mention.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all mentions
  Future<List<Mention>> getMentions({
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

      final response = await _dioClient.get('/api/v1/mention', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => Mention.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create Mention
  Future<Mention> createMention(Mention mention) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/mention',
        data: mention.toJson(),
      );
      return Mention.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update Mention
  Future<Mention> updateMention(String id, Mention mention) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/mention/$id',
        data: mention.toJson(),
      );
      return Mention.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete Mention
  Future<void> deleteMention(String id) async {
    try {
      await _dioClient.delete('/api/v1/mention/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
