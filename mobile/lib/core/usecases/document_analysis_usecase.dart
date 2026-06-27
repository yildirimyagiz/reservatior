import 'package:reservatior/shared/repositories/document_analysis_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetDocumentAnalysisByIdUseCase {
  final DocumentAnalysisRepository _repository;
  GetDocumentAnalysisByIdUseCase(this._repository);
  Future<DocumentAnalysis> execute(String id) => _repository.getById(id);
}

class GetDocumentAnalysissUseCase {
  final DocumentAnalysisRepository _repository;
  GetDocumentAnalysissUseCase(this._repository);
  Future<List<DocumentAnalysis>> execute({
    int page = 1, 
    int limit = 20, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) => _repository.getAll(
    page: page, 
    limit: limit, 
    filters: filters,
    sortBy: sortBy,
    sortOrder: sortOrder,
  );
}

class CreateDocumentAnalysisUseCase {
  final DocumentAnalysisRepository _repository;
  CreateDocumentAnalysisUseCase(this._repository);
  Future<DocumentAnalysis> execute(DocumentAnalysis item) => _repository.create(item);
}

class UpdateDocumentAnalysisUseCase {
  final DocumentAnalysisRepository _repository;
  UpdateDocumentAnalysisUseCase(this._repository);
  Future<DocumentAnalysis> execute(String id, DocumentAnalysis item) => _repository.update(id, item);
}

class DeleteDocumentAnalysisUseCase {
  final DocumentAnalysisRepository _repository;
  DeleteDocumentAnalysisUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
