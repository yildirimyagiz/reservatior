import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/agency_service.dart';

abstract class AgencyRepository {
  Future<Agency> getById(String id);
  Future<List<Agency>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<Agency> create(Agency item);
  Future<Agency> update(String id, Agency item);
  Future<void> delete(String id);
  Future<List<Map<String, dynamic>>> getAgents(String id);
  Future<Map<String, dynamic>> getStats(String id);
  Future<List<Map<String, dynamic>>> getListings(String id);
}

class AgencyRepositoryImpl implements AgencyRepository {
  final AgencyService _service;
  AgencyRepositoryImpl(this._service);

  @override
  Future<Agency> getById(String id) => _service.getAgencyById(id);

  @override
  Future<List<Agency>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getAgencies(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<Agency> create(Agency item) => _service.createAgency(item);

  @override
  Future<Agency> update(String id, Agency item) => _service.updateAgency(id, item);

  @override
  Future<void> delete(String id) => _service.deleteAgency(id);

  @override
  Future<List<Map<String, dynamic>>> getAgents(String id) => _service.getAgents(id);

  @override
  Future<Map<String, dynamic>> getStats(String id) => _service.getStats(id);

  @override
  Future<List<Map<String, dynamic>>> getListings(String id) => _service.getListings(id);
}
