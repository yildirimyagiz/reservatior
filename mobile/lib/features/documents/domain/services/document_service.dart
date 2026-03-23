import '../entities/document.dart';
import '../entities/document_analysis.dart';
import '../entities/document_template.dart';
import '../repositories/document_repository.dart';

// ── Document Service
// Document iş mantığı için service

class DocumentService {
  final DocumentRepository _repository;

  DocumentService(this._repository);

  // Document operations
  Future<List<Document>> getAllDocuments() => _repository.getDocuments();
  
  Future<Document?> getDocument(String id) async {
    final document = await _repository.getDocumentById(id);
    if (document != null) {
      // Load related analyses and template
      final analyses = await _repository.getDocumentAnalyses(id);
      final template = document.templateId != null 
          ? await _repository.getDocumentTemplateById(document.templateId!) 
          : null;
      
      return document.copyWith(
        analyses: analyses,
        template: template,
      );
    }
    return null;
  }

  Future<List<Document>> getDocumentsByOrganization(String orgId) => 
      _repository.getDocumentsByOrgId(orgId);

  Future<List<Document>> getDocumentsByContract(String contractId) => 
      _repository.getDocumentsByContractId(contractId);

  Future<List<Document>> getDocumentsByProperty(String propertyId) => 
      _repository.getDocumentsByPropertyId(propertyId);

  Future<List<Document>> getDocumentsByType(DocumentType type) => 
      _repository.getDocumentsByType(type);

  Future<Document> createDocument(Document document) async {
    final createdDocument = await _repository.createDocument(document);
    
    // If template is specified, apply template
    if (document.templateId != null) {
      final template = await _repository.getDocumentTemplateById(document.templateId!);
      if (template != null) {
        return await _applyTemplate(createdDocument, template);
      }
    }
    
    return createdDocument;
  }

  Future<Document> updateDocument(Document document) => 
      _repository.updateDocument(document);

  Future<void> deleteDocument(String id) => _repository.deleteDocument(id);

  Future<List<Document>> searchDocuments(String query) => 
      _repository.searchDocuments(query);

  // Document Analysis operations
  Future<List<DocumentAnalysis>> getDocumentAnalyses(String documentId) => 
      _repository.getDocumentAnalyses(documentId);

  Future<DocumentAnalysis> createAnalysis(DocumentAnalysis analysis) => 
      _repository.createDocumentAnalysis(analysis);

  Future<DocumentAnalysis> updateAnalysis(DocumentAnalysis analysis) => 
      _repository.updateDocumentAnalysis(analysis);

  Future<void> deleteAnalysis(String id) => _repository.deleteDocumentAnalysis(id);

  // Document Template operations
  Future<List<DocumentTemplate>> getAllTemplates() => _repository.getDocumentTemplates();
  
  Future<List<DocumentTemplate>> getActiveTemplates() => _repository.getActiveTemplates();

  Future<DocumentTemplate> createTemplate(DocumentTemplate template) => 
      _repository.createDocumentTemplate(template);

  Future<DocumentTemplate> updateTemplate(DocumentTemplate template) => 
      _repository.updateDocumentTemplate(template);

  Future<void> deleteTemplate(String id) => _repository.deleteDocumentTemplate(id);

  // Business logic methods
  Future<Document> _applyTemplate(Document document, DocumentTemplate template) async {
    // Apply template logic here
    String content = template.templateContent ?? '';
    
    // Replace template variables with document data
    if (template.variables != null) {
      // Variable replacement logic
    }
    
    return document.copyWith(
      title: document.title ?? template.name,
      // Update other fields based on template
    );
  }

  Future<bool> isDocumentExpired(Document document) async {
    if (document.expiryDate == null) return false;
    return DateTime.now().isAfter(document.expiryDate!);
  }

  Future<bool> isDocumentCompliant(Document document) async {
    // Compliance check logic
    return document.complianceType != null;
  }

  Future<List<Document>> getRequiredDocuments(String contractId) async {
    final documents = await getDocumentsByContract(contractId);
    return documents.where((doc) => doc.isRequired == true).toList();
  }

  Future<List<Document>> getPendingSignatureDocuments(String userId) async {
    final documents = await getDocumentsByOrganization(userId);
    return documents
        .where((doc) => 
            doc.signatureRequired == true && 
            doc.isSigned != true)
        .toList();
  }
}
