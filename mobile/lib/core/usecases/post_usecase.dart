import 'package:reservatior/shared/repositories/post_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetPostByIdUseCase {
  final PostRepository _repository;
  GetPostByIdUseCase(this._repository);
  Future<Post> execute(String id) => _repository.getById(id);
}

class GetPostsUseCase {
  final PostRepository _repository;
  GetPostsUseCase(this._repository);
  Future<List<Post>> execute({
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

class CreatePostUseCase {
  final PostRepository _repository;
  CreatePostUseCase(this._repository);
  Future<Post> execute(Post item) => _repository.create(item);
}

class UpdatePostUseCase {
  final PostRepository _repository;
  UpdatePostUseCase(this._repository);
  Future<Post> execute(String id, Post item) => _repository.update(id, item);
}

class DeletePostUseCase {
  final PostRepository _repository;
  DeletePostUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
