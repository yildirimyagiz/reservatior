import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/lead_service.dart';

abstract class LeadRepository {
  Future<Lead> getById(String id);
  Future<List<Lead>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<Lead> create(Lead item);
  Future<Lead> update(String id, Lead item);
  Future<void> delete(String id);
}

class LeadRepositoryImpl implements LeadRepository {
  final LeadService _service;
  LeadRepositoryImpl(this._service);

  @override
  Future<Lead> getById(String id) => _service.getLeadById(id);

  @override
  Future<List<Lead>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getLeads(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<Lead> create(Lead item) => _service.createLead(item);

  @override
  Future<Lead> update(String id, Lead item) => _service.updateLead(id, item);

  @override
  Future<void> delete(String id) => _service.deleteLead(id);
}
