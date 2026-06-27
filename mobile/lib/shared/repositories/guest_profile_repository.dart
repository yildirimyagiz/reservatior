import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/guest_profile_service.dart';

abstract class GuestProfileRepository {
  Future<GuestProfile> getById(String id);
  Future<List<GuestProfile>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<GuestProfile> create(GuestProfile item);
  Future<GuestProfile> update(String id, GuestProfile item);
  Future<void> delete(String id);
}

class GuestProfileRepositoryImpl implements GuestProfileRepository {
  final GuestProfileService _service;
  GuestProfileRepositoryImpl(this._service);

  @override
  Future<GuestProfile> getById(String id) => _service.getGuestProfileById(id);

  @override
  Future<List<GuestProfile>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getGuestProfiles(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<GuestProfile> create(GuestProfile item) => _service.createGuestProfile(item);

  @override
  Future<GuestProfile> update(String id, GuestProfile item) => _service.updateGuestProfile(id, item);

  @override
  Future<void> delete(String id) => _service.deleteGuestProfile(id);
}
