import '../../features/shared/services/video_content_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for VideoContent

class GetVideoContentByIdUseCase {
  final VideoContentService _service;
  
  GetVideoContentByIdUseCase(this._service);
  
  Future<VideoContent> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetVideoContentsUseCase {
  final VideoContentService _service;
  
  GetVideoContentsUseCase(this._service);
  
  Future<List<VideoContent>> execute({
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

class CreateVideoContentUseCase {
  final VideoContentService _service;
  
  CreateVideoContentUseCase(this._service);
  
  Future<VideoContent> execute(VideoContent videoContent) async {
    // Add validation logic here
    return await _service.create(videoContent);
  }
}

class UpdateVideoContentUseCase {
  final VideoContentService _service;
  
  UpdateVideoContentUseCase(this._service);
  
  Future<VideoContent> execute(String id, VideoContent videoContent) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, videoContent);
  }
}

class DeleteVideoContentUseCase {
  final VideoContentService _service;
  
  DeleteVideoContentUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// VideoContent Use Case Container
class VideoContentUseCases {
  final GetVideoContentByIdUseCase getById;
  final GetVideoContentsUseCase getAll;
  final CreateVideoContentUseCase create;
  final UpdateVideoContentUseCase update;
  final DeleteVideoContentUseCase delete;
  
  VideoContentUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory VideoContentUseCases.create(VideoContentService service) {
    return VideoContentUseCases(
      getById: GetVideoContentByIdUseCase(service),
      getAll: GetVideoContentsUseCase(service),
      create: CreateVideoContentUseCase(service),
      update: UpdateVideoContentUseCase(service),
      delete: DeleteVideoContentUseCase(service),
    );
  }
}
