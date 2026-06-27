import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/document_service.dart';

abstract class DocumentRepository {
  Future<Document> getById(String id);
  Future<List<Document>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<Document> create(Document item);
  Future<Document> update(String id, Document item);
  Future<void> delete(String id);
}

class DocumentRepositoryImpl implements DocumentRepository {
  final DocumentService _service;
  DocumentRepositoryImpl(this._service);

  @override
  Future<Document> getById(String id) => _service.getDocumentById(id);

  @override
  Future<List<Document>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getDocuments(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<Document> create(Document item) => _service.createDocument(item);

  @override
  Future<Document> update(String id, Document item) => _service.updateDocument(id, item);

  @override
  Future<void> delete(String id) => _service.deleteDocument(id);
}
