import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/hashtag_service.dart';

abstract class HashtagRepository {
  Future<Hashtag> getById(String id);
  Future<List<Hashtag>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<Hashtag> create(Hashtag item);
  Future<Hashtag> update(String id, Hashtag item);
  Future<void> delete(String id);
}

class HashtagRepositoryImpl implements HashtagRepository {
  final HashtagService _service;
  HashtagRepositoryImpl(this._service);

  @override
  Future<Hashtag> getById(String id) => _service.getHashtagById(id);

  @override
  Future<List<Hashtag>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getHashtags(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<Hashtag> create(Hashtag item) => _service.createHashtag(item);

  @override
  Future<Hashtag> update(String id, Hashtag item) => _service.updateHashtag(id, item);

  @override
  Future<void> delete(String id) => _service.deleteHashtag(id);
}
