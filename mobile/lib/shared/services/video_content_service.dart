import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class VideoContentService {
  final DioClient _dioClient;
  VideoContentService(this._dioClient);

  Future<VideoContent> getVideoContentById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.videoContents}/$id');
    return VideoContent.fromJson(response.data['data']);
  }

  Future<List<VideoContent>> getVideoContents({
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
    final response = await _dioClient.get(ApiEndpoints.videoContents, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => VideoContent.fromJson(json)).toList();
  }

  Future<VideoContent> createVideoContent(VideoContent item) async {
    final response = await _dioClient.post(ApiEndpoints.videoContents, data: item.toJson());
    return VideoContent.fromJson(response.data['data']);
  }

  Future<VideoContent> updateVideoContent(String id, VideoContent item) async {
    final response = await _dioClient.patch('${ApiEndpoints.videoContents}/$id', data: item.toJson());
    return VideoContent.fromJson(response.data['data']);
  }

  Future<void> deleteVideoContent(String id) async {
    await _dioClient.delete('${ApiEndpoints.videoContents}/$id');
  }
}
