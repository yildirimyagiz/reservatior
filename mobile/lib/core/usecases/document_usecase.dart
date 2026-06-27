import 'package:reservatior/shared/repositories/document_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetDocumentByIdUseCase {
  final DocumentRepository _repository;
  GetDocumentByIdUseCase(this._repository);
  Future<Document> execute(String id) => _repository.getById(id);
}

class GetDocumentsUseCase {
  final DocumentRepository _repository;
  GetDocumentsUseCase(this._repository);
  Future<List<Document>> execute({
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

class CreateDocumentUseCase {
  final DocumentRepository _repository;
  CreateDocumentUseCase(this._repository);
  Future<Document> execute(Document item) => _repository.create(item);
}

class UpdateDocumentUseCase {
  final DocumentRepository _repository;
  UpdateDocumentUseCase(this._repository);
  Future<Document> execute(String id, Document item) => _repository.update(id, item);
}

class DeleteDocumentUseCase {
  final DocumentRepository _repository;
  DeleteDocumentUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
