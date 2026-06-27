import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/lead_source_service.dart';

abstract class LeadSourceRepository {
  Future<LeadSource> getById(String id);
  Future<List<LeadSource>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<LeadSource> create(LeadSource item);
  Future<LeadSource> update(String id, LeadSource item);
  Future<void> delete(String id);
}

class LeadSourceRepositoryImpl implements LeadSourceRepository {
  final LeadSourceService _service;
  LeadSourceRepositoryImpl(this._service);

  @override
  Future<LeadSource> getById(String id) => _service.getLeadSourceById(id);

  @override
  Future<List<LeadSource>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getLeadSources(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<LeadSource> create(LeadSource item) => _service.createLeadSource(item);

  @override
  Future<LeadSource> update(String id, LeadSource item) => _service.updateLeadSource(id, item);

  @override
  Future<void> delete(String id) => _service.deleteLeadSource(id);
}
