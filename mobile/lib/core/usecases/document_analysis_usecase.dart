import '../../features/shared/services/document_analysis_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for DocumentAnalysis

class GetDocumentAnalysisByIdUseCase {
  final DocumentAnalysisService _service;
  
  GetDocumentAnalysisByIdUseCase(this._service);
  
  Future<DocumentAnalysis> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetDocumentAnalysissUseCase {
  final DocumentAnalysisService _service;
  
  GetDocumentAnalysissUseCase(this._service);
  
  Future<List<DocumentAnalysis>> execute({
    int page = 1,
    int limit = 20,
    Map<String, dynamic>? filters,
  }) async {
    if (page <= 0) {
      throw ArgumentError('Page must be greater than 0');
    }
    if (limit <= 0 || limit > 100) {
      throw ArgumentError('Limit must be between 1 and 100');
    }
    return await _service.getAll(
      page: page,
      limit: limit,
      filters: filters,
    );
  }
}

class CreateDocumentAnalysisUseCase {
  final DocumentAnalysisService _service;
  
  CreateDocumentAnalysisUseCase(this._service);
  
  Future<DocumentAnalysis> execute(DocumentAnalysis documentAnalysis) async {
    // Add validation logic here
    return await _service.create(documentAnalysis);
  }
}

class UpdateDocumentAnalysisUseCase {
  final DocumentAnalysisService _service;
  
  UpdateDocumentAnalysisUseCase(this._service);
  
  Future<DocumentAnalysis> execute(String id, DocumentAnalysis documentAnalysis) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, documentAnalysis);
  }
}

class DeleteDocumentAnalysisUseCase {
  final DocumentAnalysisService _service;
  
  DeleteDocumentAnalysisUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// DocumentAnalysis Use Case Container
class DocumentAnalysisUseCases {
  final GetDocumentAnalysisByIdUseCase getById;
  final GetDocumentAnalysissUseCase getAll;
  final CreateDocumentAnalysisUseCase create;
  final UpdateDocumentAnalysisUseCase update;
  final DeleteDocumentAnalysisUseCase delete;
  
  DocumentAnalysisUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory DocumentAnalysisUseCases.create(DocumentAnalysisService service) {
    return DocumentAnalysisUseCases(
      getById: GetDocumentAnalysisByIdUseCase(service),
      getAll: GetDocumentAnalysissUseCase(service),
      create: CreateDocumentAnalysisUseCase(service),
      update: UpdateDocumentAnalysisUseCase(service),
      delete: DeleteDocumentAnalysisUseCase(service),
    );
  }
}
