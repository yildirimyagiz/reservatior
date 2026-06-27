import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/communication_template_service.dart';

abstract class CommunicationTemplateRepository {
  Future<CommunicationTemplate> getById(String id);
  Future<List<CommunicationTemplate>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<CommunicationTemplate> create(CommunicationTemplate item);
  Future<CommunicationTemplate> update(String id, CommunicationTemplate item);
  Future<void> delete(String id);
}

class CommunicationTemplateRepositoryImpl implements CommunicationTemplateRepository {
  final CommunicationTemplateService _service;
  CommunicationTemplateRepositoryImpl(this._service);

  @override
  Future<CommunicationTemplate> getById(String id) => _service.getCommunicationTemplateById(id);

  @override
  Future<List<CommunicationTemplate>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getCommunicationTemplates(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<CommunicationTemplate> create(CommunicationTemplate item) => _service.createCommunicationTemplate(item);

  @override
  Future<CommunicationTemplate> update(String id, CommunicationTemplate item) => _service.updateCommunicationTemplate(id, item);

  @override
  Future<void> delete(String id) => _service.deleteCommunicationTemplate(id);
}
