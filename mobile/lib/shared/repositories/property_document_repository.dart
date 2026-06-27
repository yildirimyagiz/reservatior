import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/property_document_service.dart';

abstract class PropertyDocumentRepository {
  Future<PropertyDocument> getById(String id);
  Future<List<PropertyDocument>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<PropertyDocument> create(PropertyDocument item);
  Future<PropertyDocument> update(String id, PropertyDocument item);
  Future<void> delete(String id);
}

class PropertyDocumentRepositoryImpl implements PropertyDocumentRepository {
  final PropertyDocumentService _service;
  PropertyDocumentRepositoryImpl(this._service);

  @override
  Future<PropertyDocument> getById(String id) => _service.getPropertyDocumentById(id);

  @override
  Future<List<PropertyDocument>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getPropertyDocuments(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<PropertyDocument> create(PropertyDocument item) => _service.createPropertyDocument(item);

  @override
  Future<PropertyDocument> update(String id, PropertyDocument item) => _service.updatePropertyDocument(id, item);

  @override
  Future<void> delete(String id) => _service.deletePropertyDocument(id);
}
