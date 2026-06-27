import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/user_service.dart';

abstract class UserRepository {
  Future<User> getById(String id);
  Future<List<User>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<User> create(User item);
  Future<User> update(String id, User item);
  Future<void> delete(String id);
}

class UserRepositoryImpl implements UserRepository {
  final UserService _service;
  UserRepositoryImpl(this._service);

  @override
  Future<User> getById(String id) => _service.getUserById(id);

  @override
  Future<List<User>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getUsers(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<User> create(User item) => _service.createUser(item);

  @override
  Future<User> update(String id, User item) => _service.updateUser(id, item);

  @override
  Future<void> delete(String id) => _service.deleteUser(id);
}
