import '../entities/document.dart';
import '../entities/document_analysis.dart';
import '../entities/document_template.dart';

// ── Document Repository Interface
// Tüm document işlemleri için merkezi repository interface

abstract class DocumentRepository {
  // Document operations
  Future<List<Document>> getDocuments();
  Future<Document?> getDocumentById(String id);
  Future<List<Document>> getDocumentsByOrgId(String orgId);
  Future<List<Document>> getDocumentsByContractId(String contractId);
  Future<List<Document>> getDocumentsByPropertyId(String propertyId);
  Future<List<Document>> getDocumentsByDealId(String dealId);
  Future<List<Document>> getDocumentsByUserId(String userId);
  Future<List<Document>> getDocumentsByType(DocumentType type);
  Future<Document> createDocument(Document document);
  Future<Document> updateDocument(Document document);
  Future<void> deleteDocument(String id);
  Future<List<Document>> searchDocuments(String query);

  // Document Analysis operations
  Future<List<DocumentAnalysis>> getDocumentAnalyses(String documentId);
  Future<DocumentAnalysis?> getDocumentAnalysisById(String id);
  Future<DocumentAnalysis> createDocumentAnalysis(DocumentAnalysis analysis);
  Future<DocumentAnalysis> updateDocumentAnalysis(DocumentAnalysis analysis);
  Future<void> deleteDocumentAnalysis(String id);

  // Document Template operations
  Future<List<DocumentTemplate>> getDocumentTemplates();
  Future<DocumentTemplate?> getDocumentTemplateById(String id);
  Future<List<DocumentTemplate>> getDocumentTemplatesByOrgId(String orgId);
  Future<List<DocumentTemplate>> getDocumentTemplatesByType(TemplateType type);
  Future<DocumentTemplate> createDocumentTemplate(DocumentTemplate template);
  Future<DocumentTemplate> updateDocumentTemplate(DocumentTemplate template);
  Future<void> deleteDocumentTemplate(String id);
  Future<List<DocumentTemplate>> getActiveTemplates();
}
