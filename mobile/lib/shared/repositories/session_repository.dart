import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/session_service.dart';

abstract class SessionRepository {
  Future<Session> getById(String id);
  Future<List<Session>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<Session> create(Session item);
  Future<Session> update(String id, Session item);
  Future<void> delete(String id);
}

class SessionRepositoryImpl implements SessionRepository {
  final SessionService _service;
  SessionRepositoryImpl(this._service);

  @override
  Future<Session> getById(String id) => _service.getSessionById(id);

  @override
  Future<List<Session>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getSessions(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<Session> create(Session item) => _service.createSession(item);

  @override
  Future<Session> update(String id, Session item) => _service.updateSession(id, item);

  @override
  Future<void> delete(String id) => _service.deleteSession(id);
}
