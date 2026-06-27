import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/guest_service.dart';

abstract class GuestRepository {
  Future<Guest> getById(String id);
  Future<List<Guest>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<Guest> create(Guest item);
  Future<Guest> update(String id, Guest item);
  Future<void> delete(String id);
}

class GuestRepositoryImpl implements GuestRepository {
  final GuestService _service;
  GuestRepositoryImpl(this._service);

  @override
  Future<Guest> getById(String id) => _service.getGuestById(id);

  @override
  Future<List<Guest>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getGuests(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<Guest> create(Guest item) => _service.createGuest(item);

  @override
  Future<Guest> update(String id, Guest item) => _service.updateGuest(id, item);

  @override
  Future<void> delete(String id) => _service.deleteGuest(id);
}
