import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/user_activity_log_service.dart';

abstract class UserActivityLogRepository {
  Future<UserActivityLog> getById(String id);
  Future<List<UserActivityLog>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<UserActivityLog> create(UserActivityLog item);
  Future<UserActivityLog> update(String id, UserActivityLog item);
  Future<void> delete(String id);
}

class UserActivityLogRepositoryImpl implements UserActivityLogRepository {
  final UserActivityLogService _service;
  UserActivityLogRepositoryImpl(this._service);

  @override
  Future<UserActivityLog> getById(String id) => _service.getUserActivityLogById(id);

  @override
  Future<List<UserActivityLog>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getUserActivityLogs(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<UserActivityLog> create(UserActivityLog item) => _service.createUserActivityLog(item);

  @override
  Future<UserActivityLog> update(String id, UserActivityLog item) => _service.updateUserActivityLog(id, item);

  @override
  Future<void> delete(String id) => _service.deleteUserActivityLog(id);
}
