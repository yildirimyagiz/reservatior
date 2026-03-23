import '../../features/shared/services/tag_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for Tag

class GetTagByIdUseCase {
  final TagService _service;
  
  GetTagByIdUseCase(this._service);
  
  Future<Tag> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetTagsUseCase {
  final TagService _service;
  
  GetTagsUseCase(this._service);
  
  Future<List<Tag>> execute({
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

class CreateTagUseCase {
  final TagService _service;
  
  CreateTagUseCase(this._service);
  
  Future<Tag> execute(Tag tag) async {
    // Add validation logic here
    return await _service.create(tag);
  }
}

class UpdateTagUseCase {
  final TagService _service;
  
  UpdateTagUseCase(this._service);
  
  Future<Tag> execute(String id, Tag tag) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, tag);
  }
}

class DeleteTagUseCase {
  final TagService _service;
  
  DeleteTagUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// Tag Use Case Container
class TagUseCases {
  final GetTagByIdUseCase getById;
  final GetTagsUseCase getAll;
  final CreateTagUseCase create;
  final UpdateTagUseCase update;
  final DeleteTagUseCase delete;
  
  TagUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory TagUseCases.create(TagService service) {
    return TagUseCases(
      getById: GetTagByIdUseCase(service),
      getAll: GetTagsUseCase(service),
      create: CreateTagUseCase(service),
      update: UpdateTagUseCase(service),
      delete: DeleteTagUseCase(service),
    );
  }
}
