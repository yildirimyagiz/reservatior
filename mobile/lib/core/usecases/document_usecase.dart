import '../../features/shared/services/document_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for Document

class GetDocumentByIdUseCase {
  final DocumentService _service;
  
  GetDocumentByIdUseCase(this._service);
  
  Future<Document> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetDocumentsUseCase {
  final DocumentService _service;
  
  GetDocumentsUseCase(this._service);
  
  Future<List<Document>> execute({
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

class CreateDocumentUseCase {
  final DocumentService _service;
  
  CreateDocumentUseCase(this._service);
  
  Future<Document> execute(Document document) async {
    // Add validation logic here
    return await _service.create(document);
  }
}

class UpdateDocumentUseCase {
  final DocumentService _service;
  
  UpdateDocumentUseCase(this._service);
  
  Future<Document> execute(String id, Document document) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, document);
  }
}

class DeleteDocumentUseCase {
  final DocumentService _service;
  
  DeleteDocumentUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// Document Use Case Container
class DocumentUseCases {
  final GetDocumentByIdUseCase getById;
  final GetDocumentsUseCase getAll;
  final CreateDocumentUseCase create;
  final UpdateDocumentUseCase update;
  final DeleteDocumentUseCase delete;
  
  DocumentUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory DocumentUseCases.create(DocumentService service) {
    return DocumentUseCases(
      getById: GetDocumentByIdUseCase(service),
      getAll: GetDocumentsUseCase(service),
      create: CreateDocumentUseCase(service),
      update: UpdateDocumentUseCase(service),
      delete: DeleteDocumentUseCase(service),
    );
  }
}
