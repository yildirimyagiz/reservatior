import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/vendor_profile_service.dart';

abstract class VendorProfileRepository {
  Future<VendorProfile> getById(String id);
  Future<List<VendorProfile>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<VendorProfile> create(VendorProfile item);
  Future<VendorProfile> update(String id, VendorProfile item);
  Future<void> delete(String id);
}

class VendorProfileRepositoryImpl implements VendorProfileRepository {
  final VendorProfileService _service;
  VendorProfileRepositoryImpl(this._service);

  @override
  Future<VendorProfile> getById(String id) => _service.getVendorProfileById(id);

  @override
  Future<List<VendorProfile>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getVendorProfiles(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<VendorProfile> create(VendorProfile item) => _service.createVendorProfile(item);

  @override
  Future<VendorProfile> update(String id, VendorProfile item) => _service.updateVendorProfile(id, item);

  @override
  Future<void> delete(String id) => _service.deleteVendorProfile(id);
}
