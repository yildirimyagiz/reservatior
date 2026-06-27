import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/tag_service.dart';

abstract class TagRepository {
  Future<Tag> getById(String id);
  Future<List<Tag>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<Tag> create(Tag item);
  Future<Tag> update(String id, Tag item);
  Future<void> delete(String id);
}

class TagRepositoryImpl implements TagRepository {
  final TagService _service;
  TagRepositoryImpl(this._service);

  @override
  Future<Tag> getById(String id) => _service.getTagById(id);

  @override
  Future<List<Tag>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getTags(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<Tag> create(Tag item) => _service.createTag(item);

  @override
  Future<Tag> update(String id, Tag item) => _service.updateTag(id, item);

  @override
  Future<void> delete(String id) => _service.deleteTag(id);
}
