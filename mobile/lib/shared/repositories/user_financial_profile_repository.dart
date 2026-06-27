import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/user_financial_profile_service.dart';

abstract class UserFinancialProfileRepository {
  Future<UserFinancialProfile> getById(String id);
  Future<List<UserFinancialProfile>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<UserFinancialProfile> create(UserFinancialProfile item);
  Future<UserFinancialProfile> update(String id, UserFinancialProfile item);
  Future<void> delete(String id);
}

class UserFinancialProfileRepositoryImpl implements UserFinancialProfileRepository {
  final UserFinancialProfileService _service;
  UserFinancialProfileRepositoryImpl(this._service);

  @override
  Future<UserFinancialProfile> getById(String id) => _service.getUserFinancialProfileById(id);

  @override
  Future<List<UserFinancialProfile>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getUserFinancialProfiles(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<UserFinancialProfile> create(UserFinancialProfile item) => _service.createUserFinancialProfile(item);

  @override
  Future<UserFinancialProfile> update(String id, UserFinancialProfile item) => _service.updateUserFinancialProfile(id, item);

  @override
  Future<void> delete(String id) => _service.deleteUserFinancialProfile(id);
}
