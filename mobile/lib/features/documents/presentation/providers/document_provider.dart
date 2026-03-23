import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/document.dart';
import '../../domain/entities/document_analysis.dart';
import '../../domain/entities/document_template.dart';
import '../../domain/services/document_service.dart';

// ── Document Providers
// Riverpod providers for document management

// Service provider
final documentServiceProvider = Provider<DocumentService>((ref) {
  // TODO: Inject actual repository implementation
  throw UnimplementedError('DocumentService not implemented yet');
});

// Document providers
final documentsProvider = FutureProvider<List<Document>>((ref) async {
  final service = ref.watch(documentServiceProvider);
  return service.getAllDocuments();
});

final documentProvider = FutureProvider.family<Document?, String>((ref, id) async {
  final service = ref.watch(documentServiceProvider);
  return service.getDocument(id);
});

final documentsByOrgProvider = FutureProvider.family<List<Document>, String>((ref, orgId) async {
  final service = ref.watch(documentServiceProvider);
  return service.getDocumentsByOrganization(orgId);
});

final documentsByContractProvider = FutureProvider.family<List<Document>, String>((ref, contractId) async {
  final service = ref.watch(documentServiceProvider);
  return service.getDocumentsByContract(contractId);
});

final documentsByPropertyProvider = FutureProvider.family<List<Document>, String>((ref, propertyId) async {
  final service = ref.watch(documentServiceProvider);
  return service.getDocumentsByProperty(propertyId);
});

final documentsByTypeProvider = FutureProvider.family<List<Document>, DocumentType>((ref, type) async {
  final service = ref.watch(documentServiceProvider);
  return service.getDocumentsByType(type);
});

// Document search provider
final documentSearchProvider = FutureProvider.family<List<Document>, String>((ref, query) async {
  final service = ref.watch(documentServiceProvider);
  return service.searchDocuments(query);
});

// Document Analysis providers
final documentAnalysesProvider = FutureProvider.family<List<DocumentAnalysis>, String>((ref, documentId) async {
  final service = ref.watch(documentServiceProvider);
  return service.getDocumentAnalyses(documentId);
});

// Document Template providers
final documentTemplatesProvider = FutureProvider<List<DocumentTemplate>>((ref) async {
  final service = ref.watch(documentServiceProvider);
  return service.getAllTemplates();
});

final activeDocumentTemplatesProvider = FutureProvider<List<DocumentTemplate>>((ref) async {
  final service = ref.watch(documentServiceProvider);
  return service.getActiveTemplates();
});

final documentTemplateProvider = FutureProvider.family<DocumentTemplate?, String>((ref, id) async {
  final service = ref.watch(documentServiceProvider);
  // TODO: Add getDocumentTemplate method to service
  throw UnimplementedError('getDocumentTemplate not implemented yet');
});

// Document operations providers
final createDocumentProvider = FutureProvider.autoDispose.family<Document, Document>((ref, document) async {
  final service = ref.watch(documentServiceProvider);
  return service.createDocument(document);
});

final updateDocumentProvider = FutureProvider.autoDispose.family<Document, Document>((ref, document) async {
  final service = ref.watch(documentServiceProvider);
  return service.updateDocument(document);
});

final deleteDocumentProvider = FutureProvider.autoDispose.family<void, String>((ref, id) async {
  final service = ref.watch(documentServiceProvider);
  await service.deleteDocument(id);
});

// Document Analysis operations providers
final createAnalysisProvider = FutureProvider.autoDispose.family<DocumentAnalysis, DocumentAnalysis>((ref, analysis) async {
  final service = ref.watch(documentServiceProvider);
  return service.createAnalysis(analysis);
});

final updateAnalysisProvider = FutureProvider.autoDispose.family<DocumentAnalysis, DocumentAnalysis>((ref, analysis) async {
  final service = ref.watch(documentServiceProvider);
  return service.updateAnalysis(analysis);
});

// Document Template operations providers
final createTemplateProvider = FutureProvider.autoDispose.family<DocumentTemplate, DocumentTemplate>((ref, template) async {
  final service = ref.watch(documentServiceProvider);
  return service.createTemplate(template);
});

final updateTemplateProvider = FutureProvider.autoDispose.family<DocumentTemplate, DocumentTemplate>((ref, template) async {
  final service = ref.watch(documentServiceProvider);
  return service.updateTemplate(template);
});

// Business logic providers
final requiredDocumentsProvider = FutureProvider.family<List<Document>, String>((ref, contractId) async {
  final service = ref.watch(documentServiceProvider);
  return service.getRequiredDocuments(contractId);
});

final pendingSignatureDocumentsProvider = FutureProvider.family<List<Document>, String>((ref, userId) async {
  final service = ref.watch(documentServiceProvider);
  return service.getPendingSignatureDocuments(userId);
});
