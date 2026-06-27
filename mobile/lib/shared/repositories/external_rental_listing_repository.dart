import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/external_rental_listing_service.dart';

abstract class ExternalRentalListingRepository {
  Future<ExternalRentalListing> getById(String id);
  Future<List<ExternalRentalListing>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<ExternalRentalListing> create(ExternalRentalListing item);
  Future<ExternalRentalListing> update(String id, ExternalRentalListing item);
  Future<void> delete(String id);
}

class ExternalRentalListingRepositoryImpl implements ExternalRentalListingRepository {
  final ExternalRentalListingService _service;
  ExternalRentalListingRepositoryImpl(this._service);

  @override
  Future<ExternalRentalListing> getById(String id) => _service.getExternalRentalListingById(id);

  @override
  Future<List<ExternalRentalListing>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getExternalRentalListings(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<ExternalRentalListing> create(ExternalRentalListing item) => _service.createExternalRentalListing(item);

  @override
  Future<ExternalRentalListing> update(String id, ExternalRentalListing item) => _service.updateExternalRentalListing(id, item);

  @override
  Future<void> delete(String id) => _service.deleteExternalRentalListing(id);
}
