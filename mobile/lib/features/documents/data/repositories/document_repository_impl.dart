import '../../domain/entities/document.dart';
import '../../domain/entities/document_analysis.dart';
import '../../domain/entities/document_template.dart';
import '../../domain/repositories/document_repository.dart';
import '../datasources/document_datasource.dart';
import '../models/document_model.dart';
import '../models/document_analysis_model.dart';
import '../models/document_template_model.dart';

// ── Document Repository Implementation
// Repository interface'inin implementasyonu

class DocumentRepositoryImpl implements DocumentRepository {
  final DocumentDataSource _dataSource;

  DocumentRepositoryImpl(this._dataSource);

  @override
  Future<List<Document>> getDocuments() async {
    final documentModels = await _dataSource.getDocuments();
    return documentModels.map((model) => _mapToDocumentEntity(model)).toList();
  }

  @override
  Future<Document?> getDocumentById(String id) async {
    final documentModel = await _dataSource.getDocumentById(id);
    return documentModel != null ? _mapToDocumentEntity(documentModel) : null;
  }

  @override
  Future<List<Document>> getDocumentsByOrgId(String orgId) async {
    final documentModels = await _dataSource.getDocumentsByOrgId(orgId);
    return documentModels.map((model) => _mapToDocumentEntity(model)).toList();
  }

  @override
  Future<List<Document>> getDocumentsByContractId(String contractId) async {
    final documentModels = await _dataSource.getDocumentsByContractId(contractId);
    return documentModels.map((model) => _mapToDocumentEntity(model)).toList();
  }

  @override
  Future<List<Document>> getDocumentsByPropertyId(String propertyId) async {
    final documentModels = await _dataSource.getDocumentsByPropertyId(propertyId);
    return documentModels.map((model) => _mapToDocumentEntity(model)).toList();
  }

  @override
  Future<List<Document>> getDocumentsByDealId(String dealId) async {
    final documentModels = await _dataSource.getDocumentsByDealId(dealId);
    return documentModels.map((model) => _mapToDocumentEntity(model)).toList();
  }

  @override
  Future<List<Document>> getDocumentsByUserId(String userId) async {
    final documentModels = await _dataSource.getDocumentsByUserId(userId);
    return documentModels.map((model) => _mapToDocumentEntity(model)).toList();
  }

  @override
  Future<List<Document>> getDocumentsByType(DocumentType type) async {
    final documentModels = await _dataSource.getDocumentsByType(type);
    return documentModels.map((model) => _mapToDocumentEntity(model)).toList();
  }

  @override
  Future<Document> createDocument(Document document) async {
    final documentModel = _mapToDocumentModel(document);
    final createdModel = await _dataSource.createDocument(documentModel);
    return _mapToDocumentEntity(createdModel);
  }

  @override
  Future<Document> updateDocument(Document document) async {
    final documentModel = _mapToDocumentModel(document);
    final updatedModel = await _dataSource.updateDocument(documentModel);
    return _mapToDocumentEntity(updatedModel);
  }

  @override
  Future<void> deleteDocument(String id) async {
    await _dataSource.deleteDocument(id);
  }

  @override
  Future<List<Document>> searchDocuments(String query) async {
    final documentModels = await _dataSource.searchDocuments(query);
    return documentModels.map((model) => _mapToDocumentEntity(model)).toList();
  }

  @override
  Future<List<DocumentAnalysis>> getDocumentAnalyses(String documentId) async {
    final analysisModels = await _dataSource.getDocumentAnalyses(documentId);
    return analysisModels.map((model) => _mapToDocumentAnalysisEntity(model)).toList();
  }

  @override
  Future<DocumentAnalysis?> getDocumentAnalysisById(String id) async {
    final analysisModel = await _dataSource.getDocumentAnalysisById(id);
    return analysisModel != null ? _mapToDocumentAnalysisEntity(analysisModel) : null;
  }

  @override
  Future<DocumentAnalysis> createDocumentAnalysis(DocumentAnalysis analysis) async {
    final analysisModel = _mapToDocumentAnalysisModel(analysis);
    final createdModel = await _dataSource.createDocumentAnalysis(analysisModel);
    return _mapToDocumentAnalysisEntity(createdModel);
  }

  @override
  Future<DocumentAnalysis> updateDocumentAnalysis(DocumentAnalysis analysis) async {
    final analysisModel = _mapToDocumentAnalysisModel(analysis);
    final updatedModel = await _dataSource.updateDocumentAnalysis(analysisModel);
    return _mapToDocumentAnalysisEntity(updatedModel);
  }

  @override
  Future<void> deleteDocumentAnalysis(String id) async {
    await _dataSource.deleteDocumentAnalysis(id);
  }

  @override
  Future<List<DocumentTemplate>> getDocumentTemplates() async {
    final templateModels = await _dataSource.getDocumentTemplates();
    return templateModels.map((model) => _mapToDocumentTemplateEntity(model)).toList();
  }

  @override
  Future<DocumentTemplate?> getDocumentTemplateById(String id) async {
    final templateModel = await _dataSource.getDocumentTemplateById(id);
    return templateModel != null ? _mapToDocumentTemplateEntity(templateModel) : null;
  }

  @override
  Future<List<DocumentTemplate>> getDocumentTemplatesByOrgId(String orgId) async {
    final templateModels = await _dataSource.getDocumentTemplatesByOrgId(orgId);
    return templateModels.map((model) => _mapToDocumentTemplateEntity(model)).toList();
  }

  @override
  Future<List<DocumentTemplate>> getDocumentTemplatesByType(TemplateType type) async {
    final templateModels = await _dataSource.getDocumentTemplatesByType(type);
    return templateModels.map((model) => _mapToDocumentTemplateEntity(model)).toList();
  }

  @override
  Future<DocumentTemplate> createDocumentTemplate(DocumentTemplate template) async {
    final templateModel = _mapToDocumentTemplateModel(template);
    final createdModel = await _dataSource.createDocumentTemplate(templateModel);
    return _mapToDocumentTemplateEntity(createdModel);
  }

  @override
  Future<DocumentTemplate> updateDocumentTemplate(DocumentTemplate template) async {
    final templateModel = _mapToDocumentTemplateModel(template);
    final updatedModel = await _dataSource.updateDocumentTemplate(templateModel);
    return _mapToDocumentTemplateEntity(updatedModel);
  }

  @override
  Future<void> deleteDocumentTemplate(String id) async {
    await _dataSource.deleteDocumentTemplate(id);
  }

  @override
  Future<List<DocumentTemplate>> getActiveTemplates() async {
    final templateModels = await _dataSource.getActiveTemplates();
    return templateModels.map((model) => _mapToDocumentTemplateEntity(model)).toList();
  }

  // Mapping methods
  Document _mapToDocumentEntity(DocumentModel model) {
    return Document(
      id: model.id,
      orgId: model.orgId,
      dealId: model.dealId,
      propertyId: model.propertyId,
      contractId: model.contractId,
      userId: model.userId,
      listingId: model.listingId,
      documentType: model.documentType,
      title: model.title,
      description: model.description,
      fileUrl: model.fileUrl,
      fileName: model.fileName,
      fileSize: model.fileSize,
      mimeType: model.mimeType,
      checksum: model.checksum,
      version: model.version,
      isRequired: model.isRequired,
      isSigned: model.isSigned,
      signatureRequired: model.signatureRequired,
      notarizationRequired: model.notarizationRequired,
      recordingRequired: model.recordingRequired,
      expiryDate: model.expiryDate,
      complianceType: model.complianceType,
      jurisdiction: model.jurisdiction,
      templateId: model.templateId,
      tags: model.tags,
      analysisStatus: model.analysisStatus,
      lastAnalyzedAt: model.lastAnalyzedAt,
      analysisJobId: model.analysisJobId,
      duplicates: model.duplicates,
      searchVector: model.searchVector,
      createdBy: model.createdBy,
      createdAt: model.createdAt,
      updatedAt: model.updatedAt,
      deletedAt: model.deletedAt,
    );
  }

  DocumentModel _mapToDocumentModel(Document entity) {
    return DocumentModel(
      id: entity.id,
      orgId: entity.orgId,
      dealId: entity.dealId,
      propertyId: entity.propertyId,
      contractId: entity.contractId,
      userId: entity.userId,
      listingId: entity.listingId,
      documentType: entity.documentType,
      title: entity.title,
      description: entity.description,
      fileUrl: entity.fileUrl,
      fileName: entity.fileName,
      fileSize: entity.fileSize,
      mimeType: entity.mimeType,
      checksum: entity.checksum,
      version: entity.version,
      isRequired: entity.isRequired,
      isSigned: entity.isSigned,
      signatureRequired: entity.signatureRequired,
      notarizationRequired: entity.notarizationRequired,
      recordingRequired: entity.recordingRequired,
      expiryDate: entity.expiryDate,
      complianceType: entity.complianceType,
      jurisdiction: entity.jurisdiction,
      templateId: entity.templateId,
      tags: entity.tags,
      analysisStatus: entity.analysisStatus,
      lastAnalyzedAt: entity.lastAnalyzedAt,
      analysisJobId: entity.analysisJobId,
      duplicates: entity.duplicates,
      searchVector: entity.searchVector,
      createdBy: entity.createdBy,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      deletedAt: entity.deletedAt,
    );
  }

  DocumentAnalysis _mapToDocumentAnalysisEntity(DocumentAnalysisModel model) {
    return DocumentAnalysis(
      id: model.id,
      documentId: model.documentId,
      jobId: model.jobId,
      orgId: model.orgId,
      extractedText: model.extractedText,
      metadata: model.metadata,
      classification: model.classification,
      confidence: model.confidence,
      processingTime: model.processingTime,
      createdAt: model.createdAt,
      updatedAt: model.updatedAt,
    );
  }

  DocumentAnalysisModel _mapToDocumentAnalysisModel(DocumentAnalysis entity) {
    return DocumentAnalysisModel(
      id: entity.id,
      documentId: entity.documentId,
      jobId: entity.jobId,
      orgId: entity.orgId,
      extractedText: entity.extractedText,
      metadata: entity.metadata,
      classification: entity.classification,
      confidence: entity.confidence,
      processingTime: entity.processingTime,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  DocumentTemplate _mapToDocumentTemplateEntity(DocumentTemplateModel model) {
    return DocumentTemplate(
      id: model.id,
      orgId: model.orgId,
      name: model.name,
      type: model.type,
      category: model.category,
      templateContent: model.templateContent,
      variables: model.variables,
      isActive: model.isActive,
      createdBy: model.createdBy,
      createdAt: model.createdAt,
      updatedAt: model.updatedAt,
      deletedAt: model.deletedAt,
    );
  }

  DocumentTemplateModel _mapToDocumentTemplateModel(DocumentTemplate entity) {
    return DocumentTemplateModel(
      id: entity.id,
      orgId: entity.orgId,
      name: entity.name,
      type: entity.type,
      category: entity.category,
      templateContent: entity.templateContent,
      variables: entity.variables,
      isActive: entity.isActive,
      createdBy: entity.createdBy,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      deletedAt: entity.deletedAt,
    );
  }
}
