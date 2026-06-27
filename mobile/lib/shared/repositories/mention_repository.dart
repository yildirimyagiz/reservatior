import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/mention_service.dart';

abstract class MentionRepository {
  Future<Mention> getById(String id);
  Future<List<Mention>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<Mention> create(Mention item);
  Future<Mention> update(String id, Mention item);
  Future<void> delete(String id);
}

class MentionRepositoryImpl implements MentionRepository {
  final MentionService _service;
  MentionRepositoryImpl(this._service);

  @override
  Future<Mention> getById(String id) => _service.getMentionById(id);

  @override
  Future<List<Mention>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getMentions(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<Mention> create(Mention item) => _service.createMention(item);

  @override
  Future<Mention> update(String id, Mention item) => _service.updateMention(id, item);

  @override
  Future<void> delete(String id) => _service.deleteMention(id);
}
