import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/document_model.dart';
import '../models/document_analysis_model.dart';
import '../models/document_template_model.dart';
import '../../domain/entities/document.dart';
import '../../domain/entities/document_template.dart';

// ── Document Data Source
// API ve veritabanı işlemleri için data source

abstract class DocumentDataSource {
  // Document operations
  Future<List<DocumentModel>> getDocuments();
  Future<DocumentModel?> getDocumentById(String id);
  Future<List<DocumentModel>> getDocumentsByOrgId(String orgId);
  Future<List<DocumentModel>> getDocumentsByContractId(String contractId);
  Future<List<DocumentModel>> getDocumentsByPropertyId(String propertyId);
  Future<List<DocumentModel>> getDocumentsByDealId(String dealId);
  Future<List<DocumentModel>> getDocumentsByUserId(String userId);
  Future<List<DocumentModel>> getDocumentsByType(DocumentType type);
  Future<DocumentModel> createDocument(DocumentModel document);
  Future<DocumentModel> updateDocument(DocumentModel document);
  Future<void> deleteDocument(String id);
  Future<List<DocumentModel>> searchDocuments(String query);

  // Document Analysis operations
  Future<List<DocumentAnalysisModel>> getDocumentAnalyses(String documentId);
  Future<DocumentAnalysisModel?> getDocumentAnalysisById(String id);
  Future<DocumentAnalysisModel> createDocumentAnalysis(DocumentAnalysisModel analysis);
  Future<DocumentAnalysisModel> updateDocumentAnalysis(DocumentAnalysisModel analysis);
  Future<void> deleteDocumentAnalysis(String id);

  // Document Template operations
  Future<List<DocumentTemplateModel>> getDocumentTemplates();
  Future<DocumentTemplateModel?> getDocumentTemplateById(String id);
  Future<List<DocumentTemplateModel>> getDocumentTemplatesByOrgId(String orgId);
  Future<List<DocumentTemplateModel>> getDocumentTemplatesByType(TemplateType type);
  Future<DocumentTemplateModel> createDocumentTemplate(DocumentTemplateModel template);
  Future<DocumentTemplateModel> updateDocumentTemplate(DocumentTemplateModel template);
  Future<void> deleteDocumentTemplate(String id);
  Future<List<DocumentTemplateModel>> getActiveTemplates();
}

class DocumentDataSourceImpl implements DocumentDataSource {
  final http.Client _client;
  final String _baseUrl;

  DocumentDataSourceImpl(this._client, this._baseUrl);

  @override
  Future<List<DocumentModel>> getDocuments() async {
    final response = await _client.get(Uri.parse('$_baseUrl/documents'));
    
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => DocumentModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load documents: ${response.statusCode}');
    }
  }

  @override
  Future<DocumentModel?> getDocumentById(String id) async {
    final response = await _client.get(Uri.parse('$_baseUrl/documents/$id'));
    
    if (response.statusCode == 200) {
      final Map<String, dynamic> json = json.decode(response.body);
      return DocumentModel.fromJson(json);
    } else if (response.statusCode == 404) {
      return null;
    } else {
      throw Exception('Failed to load document: ${response.statusCode}');
    }
  }

  @override
  Future<List<DocumentModel>> getDocumentsByOrgId(String orgId) async {
    final response = await _client.get(Uri.parse('$_baseUrl/documents?orgId=$orgId'));
    
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => DocumentModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load documents by org: ${response.statusCode}');
    }
  }

  @override
  Future<List<DocumentModel>> getDocumentsByContractId(String contractId) async {
    final response = await _client.get(Uri.parse('$_baseUrl/documents?contractId=$contractId'));
    
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => DocumentModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load documents by contract: ${response.statusCode}');
    }
  }

  @override
  Future<List<DocumentModel>> getDocumentsByPropertyId(String propertyId) async {
    final response = await _client.get(Uri.parse('$_baseUrl/documents?propertyId=$propertyId'));
    
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => DocumentModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load documents by property: ${response.statusCode}');
    }
  }

  @override
  Future<List<DocumentModel>> getDocumentsByDealId(String dealId) async {
    final response = await _client.get(Uri.parse('$_baseUrl/documents?dealId=$dealId'));
    
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => DocumentModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load documents by deal: ${response.statusCode}');
    }
  }

  @override
  Future<List<DocumentModel>> getDocumentsByUserId(String userId) async {
    final response = await _client.get(Uri.parse('$_baseUrl/documents?userId=$userId'));
    
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => DocumentModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load documents by user: ${response.statusCode}');
    }
  }

  @override
  Future<List<DocumentModel>> getDocumentsByType(DocumentType type) async {
    final response = await _client.get(Uri.parse('$_baseUrl/documents?type=${type.name}'));
    
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => DocumentModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load documents by type: ${response.statusCode}');
    }
  }

  @override
  Future<DocumentModel> createDocument(DocumentModel document) async {
    final response = await _client.post(
      Uri.parse('$_baseUrl/documents'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(document.toJson()),
    );
    
    if (response.statusCode == 201) {
      final Map<String, dynamic> json = json.decode(response.body);
      return DocumentModel.fromJson(json);
    } else {
      throw Exception('Failed to create document: ${response.statusCode}');
    }
  }

  @override
  Future<DocumentModel> updateDocument(DocumentModel document) async {
    final response = await _client.put(
      Uri.parse('$_baseUrl/documents/${document.id}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(document.toJson()),
    );
    
    if (response.statusCode == 200) {
      final Map<String, dynamic> json = json.decode(response.body);
      return DocumentModel.fromJson(json);
    } else {
      throw Exception('Failed to update document: ${response.statusCode}');
    }
  }

  @override
  Future<void> deleteDocument(String id) async {
    final response = await _client.delete(Uri.parse('$_baseUrl/documents/$id'));
    
    if (response.statusCode != 204) {
      throw Exception('Failed to delete document: ${response.statusCode}');
    }
  }

  @override
  Future<List<DocumentModel>> searchDocuments(String query) async {
    final response = await _client.get(Uri.parse('$_baseUrl/documents/search?q=$query'));
    
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => DocumentModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to search documents: ${response.statusCode}');
    }
  }

  @override
  Future<List<DocumentAnalysisModel>> getDocumentAnalyses(String documentId) async {
    final response = await _client.get(Uri.parse('$_baseUrl/document-analyses?documentId=$documentId'));
    
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => DocumentAnalysisModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load document analyses: ${response.statusCode}');
    }
  }

  @override
  Future<DocumentAnalysisModel?> getDocumentAnalysisById(String id) async {
    final response = await _client.get(Uri.parse('$_baseUrl/document-analyses/$id'));
    
    if (response.statusCode == 200) {
      final Map<String, dynamic> json = json.decode(response.body);
      return DocumentAnalysisModel.fromJson(json);
    } else if (response.statusCode == 404) {
      return null;
    } else {
      throw Exception('Failed to load document analysis: ${response.statusCode}');
    }
  }

  @override
  Future<DocumentAnalysisModel> createDocumentAnalysis(DocumentAnalysisModel analysis) async {
    final response = await _client.post(
      Uri.parse('$_baseUrl/document-analyses'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(analysis.toJson()),
    );
    
    if (response.statusCode == 201) {
      final Map<String, dynamic> json = json.decode(response.body);
      return DocumentAnalysisModel.fromJson(json);
    } else {
      throw Exception('Failed to create document analysis: ${response.statusCode}');
    }
  }

  @override
  Future<DocumentAnalysisModel> updateDocumentAnalysis(DocumentAnalysisModel analysis) async {
    final response = await _client.put(
      Uri.parse('$_baseUrl/document-analyses/${analysis.id}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(analysis.toJson()),
    );
    
    if (response.statusCode == 200) {
      final Map<String, dynamic> json = json.decode(response.body);
      return DocumentAnalysisModel.fromJson(json);
    } else {
      throw Exception('Failed to update document analysis: ${response.statusCode}');
    }
  }

  @override
  Future<void> deleteDocumentAnalysis(String id) async {
    final response = await _client.delete(Uri.parse('$_baseUrl/document-analyses/$id'));
    
    if (response.statusCode != 204) {
      throw Exception('Failed to delete document analysis: ${response.statusCode}');
    }
  }

  @override
  Future<List<DocumentTemplateModel>> getDocumentTemplates() async {
    final response = await _client.get(Uri.parse('$_baseUrl/document-templates'));
    
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => DocumentTemplateModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load document templates: ${response.statusCode}');
    }
  }

  @override
  Future<DocumentTemplateModel?> getDocumentTemplateById(String id) async {
    final response = await _client.get(Uri.parse('$_baseUrl/document-templates/$id'));
    
    if (response.statusCode == 200) {
      final Map<String, dynamic> json = json.decode(response.body);
      return DocumentTemplateModel.fromJson(json);
    } else if (response.statusCode == 404) {
      return null;
    } else {
      throw Exception('Failed to load document template: ${response.statusCode}');
    }
  }

  @override
  Future<List<DocumentTemplateModel>> getDocumentTemplatesByOrgId(String orgId) async {
    final response = await _client.get(Uri.parse('$_baseUrl/document-templates?orgId=$orgId'));
    
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => DocumentTemplateModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load document templates by org: ${response.statusCode}');
    }
  }

  @override
  Future<List<DocumentTemplateModel>> getDocumentTemplatesByType(TemplateType type) async {
    final response = await _client.get(Uri.parse('$_baseUrl/document-templates?type=${type.name}'));
    
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => DocumentTemplateModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load document templates by type: ${response.statusCode}');
    }
  }

  @override
  Future<DocumentTemplateModel> createDocumentTemplate(DocumentTemplateModel template) async {
    final response = await _client.post(
      Uri.parse('$_baseUrl/document-templates'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(template.toJson()),
    );
    
    if (response.statusCode == 201) {
      final Map<String, dynamic> json = json.decode(response.body);
      return DocumentTemplateModel.fromJson(json);
    } else {
      throw Exception('Failed to create document template: ${response.statusCode}');
    }
  }

  @override
  Future<DocumentTemplateModel> updateDocumentTemplate(DocumentTemplateModel template) async {
    final response = await _client.put(
      Uri.parse('$_baseUrl/document-templates/${template.id}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(template.toJson()),
    );
    
    if (response.statusCode == 200) {
      final Map<String, dynamic> json = json.decode(response.body);
      return DocumentTemplateModel.fromJson(json);
    } else {
      throw Exception('Failed to update document template: ${response.statusCode}');
    }
  }

  @override
  Future<void> deleteDocumentTemplate(String id) async {
    final response = await _client.delete(Uri.parse('$_baseUrl/document-templates/$id'));
    
    if (response.statusCode != 204) {
      throw Exception('Failed to delete document template: ${response.statusCode}');
    }
  }

  @override
  Future<List<DocumentTemplateModel>> getActiveTemplates() async {
    final response = await _client.get(Uri.parse('$_baseUrl/document-templates?isActive=true'));
    
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => DocumentTemplateModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load active document templates: ${response.statusCode}');
    }
  }
}
