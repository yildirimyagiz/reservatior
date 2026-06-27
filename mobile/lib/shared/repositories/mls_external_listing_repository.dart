import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/mls_external_listing_service.dart';

abstract class MlsExternalListingRepository {
  Future<MlsExternalListing> getById(String id);
  Future<List<MlsExternalListing>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<MlsExternalListing> create(MlsExternalListing item);
  Future<MlsExternalListing> update(String id, MlsExternalListing item);
  Future<void> delete(String id);
}

class MlsExternalListingRepositoryImpl implements MlsExternalListingRepository {
  final MlsExternalListingService _service;
  MlsExternalListingRepositoryImpl(this._service);

  @override
  Future<MlsExternalListing> getById(String id) => _service.getMlsExternalListingById(id);

  @override
  Future<List<MlsExternalListing>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getMlsExternalListings(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<MlsExternalListing> create(MlsExternalListing item) => _service.createMlsExternalListing(item);

  @override
  Future<MlsExternalListing> update(String id, MlsExternalListing item) => _service.updateMlsExternalListing(id, item);

  @override
  Future<void> delete(String id) => _service.deleteMlsExternalListing(id);
}
