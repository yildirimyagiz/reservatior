import '../../features/shared/services/post_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for Post

class GetPostByIdUseCase {
  final PostService _service;
  
  GetPostByIdUseCase(this._service);
  
  Future<Post> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetPostsUseCase {
  final PostService _service;
  
  GetPostsUseCase(this._service);
  
  Future<List<Post>> execute({
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

class CreatePostUseCase {
  final PostService _service;
  
  CreatePostUseCase(this._service);
  
  Future<Post> execute(Post post) async {
    // Add validation logic here
    return await _service.create(post);
  }
}

class UpdatePostUseCase {
  final PostService _service;
  
  UpdatePostUseCase(this._service);
  
  Future<Post> execute(String id, Post post) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, post);
  }
}

class DeletePostUseCase {
  final PostService _service;
  
  DeletePostUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// Post Use Case Container
class PostUseCases {
  final GetPostByIdUseCase getById;
  final GetPostsUseCase getAll;
  final CreatePostUseCase create;
  final UpdatePostUseCase update;
  final DeletePostUseCase delete;
  
  PostUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory PostUseCases.create(PostService service) {
    return PostUseCases(
      getById: GetPostByIdUseCase(service),
      getAll: GetPostsUseCase(service),
      create: CreatePostUseCase(service),
      update: UpdatePostUseCase(service),
      delete: DeletePostUseCase(service),
    );
  }
}
