import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/video_content_service.dart';

abstract class VideoContentRepository {
  Future<VideoContent> getById(String id);
  Future<List<VideoContent>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<VideoContent> create(VideoContent item);
  Future<VideoContent> update(String id, VideoContent item);
  Future<void> delete(String id);
}

class VideoContentRepositoryImpl implements VideoContentRepository {
  final VideoContentService _service;
  VideoContentRepositoryImpl(this._service);

  @override
  Future<VideoContent> getById(String id) => _service.getVideoContentById(id);

  @override
  Future<List<VideoContent>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getVideoContents(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<VideoContent> create(VideoContent item) => _service.createVideoContent(item);

  @override
  Future<VideoContent> update(String id, VideoContent item) => _service.updateVideoContent(id, item);

  @override
  Future<void> delete(String id) => _service.deleteVideoContent(id);
}
