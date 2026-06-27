import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/mls_listing_enhancement_service.dart';

abstract class MlsListingEnhancementRepository {
  Future<MlsListingEnhancement> getById(String id);
  Future<List<MlsListingEnhancement>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<MlsListingEnhancement> create(MlsListingEnhancement item);
  Future<MlsListingEnhancement> update(String id, MlsListingEnhancement item);
  Future<void> delete(String id);
}

class MlsListingEnhancementRepositoryImpl implements MlsListingEnhancementRepository {
  final MlsListingEnhancementService _service;
  MlsListingEnhancementRepositoryImpl(this._service);

  @override
  Future<MlsListingEnhancement> getById(String id) => _service.getMlsListingEnhancementById(id);

  @override
  Future<List<MlsListingEnhancement>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getMlsListingEnhancements(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<MlsListingEnhancement> create(MlsListingEnhancement item) => _service.createMlsListingEnhancement(item);

  @override
  Future<MlsListingEnhancement> update(String id, MlsListingEnhancement item) => _service.updateMlsListingEnhancement(id, item);

  @override
  Future<void> delete(String id) => _service.deleteMlsListingEnhancement(id);
}
