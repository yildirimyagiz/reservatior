import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/post_service.dart';

abstract class PostRepository {
  Future<Post> getById(String id);
  Future<List<Post>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<Post> create(Post item);
  Future<Post> update(String id, Post item);
  Future<void> delete(String id);
}

class PostRepositoryImpl implements PostRepository {
  final PostService _service;
  PostRepositoryImpl(this._service);

  @override
  Future<Post> getById(String id) => _service.getPostById(id);

  @override
  Future<List<Post>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getPosts(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<Post> create(Post item) => _service.createPost(item);

  @override
  Future<Post> update(String id, Post item) => _service.updatePost(id, item);

  @override
  Future<void> delete(String id) => _service.deletePost(id);
}
