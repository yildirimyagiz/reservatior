import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/user_preference_service.dart';

abstract class UserPreferenceRepository {
  Future<UserPreference> getById(String id);
  Future<List<UserPreference>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<UserPreference> create(UserPreference item);
  Future<UserPreference> update(String id, UserPreference item);
  Future<void> delete(String id);
}

class UserPreferenceRepositoryImpl implements UserPreferenceRepository {
  final UserPreferenceService _service;
  UserPreferenceRepositoryImpl(this._service);

  @override
  Future<UserPreference> getById(String id) => _service.getUserPreferenceById(id);

  @override
  Future<List<UserPreference>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getUserPreferences(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<UserPreference> create(UserPreference item) => _service.createUserPreference(item);

  @override
  Future<UserPreference> update(String id, UserPreference item) => _service.updateUserPreference(id, item);

  @override
  Future<void> delete(String id) => _service.deleteUserPreference(id);
}
