import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class VideoContentService {
  final DioClient _dioClient;

  VideoContentService(this._dioClient);

  // Get VideoContent by ID
  Future<VideoContent> getVideoContentById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/video_content/$id');
      return VideoContent.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all video_contents
  Future<List<VideoContent>> getVideoContents({
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

      final response = await _dioClient.get('/api/v1/video_content', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => VideoContent.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create VideoContent
  Future<VideoContent> createVideoContent(VideoContent videoContent) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/video_content',
        data: videoContent.toJson(),
      );
      return VideoContent.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update VideoContent
  Future<VideoContent> updateVideoContent(String id, VideoContent videoContent) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/video_content/$id',
        data: videoContent.toJson(),
      );
      return VideoContent.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete VideoContent
  Future<void> deleteVideoContent(String id) async {
    try {
      await _dioClient.delete('/api/v1/video_content/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
