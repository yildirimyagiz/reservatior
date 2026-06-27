import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/listing_service.dart';

abstract class ListingRepository {
  Future<Listing> getById(String id);
  Future<List<Listing>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<Listing> create(Listing item);
  Future<Listing> update(String id, Listing item);
  Future<void> delete(String id);
}

class ListingRepositoryImpl implements ListingRepository {
  final ListingService _service;
  ListingRepositoryImpl(this._service);

  @override
  Future<Listing> getById(String id) => _service.getListingById(id);

  @override
  Future<List<Listing>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getListings(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<Listing> create(Listing item) => _service.createListing(item);

  @override
  Future<Listing> update(String id, Listing item) => _service.updateListing(id, item);

  @override
  Future<void> delete(String id) => _service.deleteListing(id);
}
