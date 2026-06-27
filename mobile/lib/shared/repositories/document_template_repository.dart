import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/document_template_service.dart';

abstract class DocumentTemplateRepository {
  Future<DocumentTemplate> getById(String id);
  Future<List<DocumentTemplate>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<DocumentTemplate> create(DocumentTemplate item);
  Future<DocumentTemplate> update(String id, DocumentTemplate item);
  Future<void> delete(String id);
}

class DocumentTemplateRepositoryImpl implements DocumentTemplateRepository {
  final DocumentTemplateService _service;
  DocumentTemplateRepositoryImpl(this._service);

  @override
  Future<DocumentTemplate> getById(String id) => _service.getDocumentTemplateById(id);

  @override
  Future<List<DocumentTemplate>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getDocumentTemplates(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<DocumentTemplate> create(DocumentTemplate item) => _service.createDocumentTemplate(item);

  @override
  Future<DocumentTemplate> update(String id, DocumentTemplate item) => _service.updateDocumentTemplate(id, item);

  @override
  Future<void> delete(String id) => _service.deleteDocumentTemplate(id);
}
