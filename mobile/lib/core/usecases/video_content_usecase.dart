import 'package:reservatior/shared/repositories/video_content_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetVideoContentByIdUseCase {
  final VideoContentRepository _repository;
  GetVideoContentByIdUseCase(this._repository);
  Future<VideoContent> execute(String id) => _repository.getById(id);
}

class GetVideoContentsUseCase {
  final VideoContentRepository _repository;
  GetVideoContentsUseCase(this._repository);
  Future<List<VideoContent>> execute({
    int page = 1, 
    int limit = 20, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) => _repository.getAll(
    page: page, 
    limit: limit, 
    filters: filters,
    sortBy: sortBy,
    sortOrder: sortOrder,
  );
}

class CreateVideoContentUseCase {
  final VideoContentRepository _repository;
  CreateVideoContentUseCase(this._repository);
  Future<VideoContent> execute(VideoContent item) => _repository.create(item);
}

class UpdateVideoContentUseCase {
  final VideoContentRepository _repository;
  UpdateVideoContentUseCase(this._repository);
  Future<VideoContent> execute(String id, VideoContent item) => _repository.update(id, item);
}

class DeleteVideoContentUseCase {
  final VideoContentRepository _repository;
  DeleteVideoContentUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
