import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/document_analysis_service.dart';

abstract class DocumentAnalysisRepository {
  Future<DocumentAnalysis> getById(String id);
  Future<List<DocumentAnalysis>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<DocumentAnalysis> create(DocumentAnalysis item);
  Future<DocumentAnalysis> update(String id, DocumentAnalysis item);
  Future<void> delete(String id);
  Future<Map<String, dynamic>> getJobStatus(String id);
  Future<List<Map<String, dynamic>>> searchContent(String orgId, String query, {Map<String, dynamic>? filters});
}

class DocumentAnalysisRepositoryImpl implements DocumentAnalysisRepository {
  final DocumentAnalysisService _service;
  DocumentAnalysisRepositoryImpl(this._service);

  @override
  Future<DocumentAnalysis> getById(String id) => _service.getDocumentAnalysisById(id);

  @override
  Future<List<DocumentAnalysis>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getDocumentAnalysises(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<DocumentAnalysis> create(DocumentAnalysis item) => _service.createDocumentAnalysis(item);

  @override
  Future<DocumentAnalysis> update(String id, DocumentAnalysis item) => _service.updateDocumentAnalysis(id, item);

  @override
  Future<void> delete(String id) => _service.deleteDocumentAnalysis(id);

  @override
  Future<Map<String, dynamic>> getJobStatus(String id) => _service.getJobStatus(id);

  @override
  Future<List<Map<String, dynamic>>> searchContent(String orgId, String query, {Map<String, dynamic>? filters}) => 
    _service.searchContent(orgId, query, filters: filters);
}
