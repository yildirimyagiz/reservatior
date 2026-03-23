import '../../features/shared/services/document_template_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for DocumentTemplate

class GetDocumentTemplateByIdUseCase {
  final DocumentTemplateService _service;
  
  GetDocumentTemplateByIdUseCase(this._service);
  
  Future<DocumentTemplate> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetDocumentTemplatesUseCase {
  final DocumentTemplateService _service;
  
  GetDocumentTemplatesUseCase(this._service);
  
  Future<List<DocumentTemplate>> execute({
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

class CreateDocumentTemplateUseCase {
  final DocumentTemplateService _service;
  
  CreateDocumentTemplateUseCase(this._service);
  
  Future<DocumentTemplate> execute(DocumentTemplate documentTemplate) async {
    // Add validation logic here
    return await _service.create(documentTemplate);
  }
}

class UpdateDocumentTemplateUseCase {
  final DocumentTemplateService _service;
  
  UpdateDocumentTemplateUseCase(this._service);
  
  Future<DocumentTemplate> execute(String id, DocumentTemplate documentTemplate) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, documentTemplate);
  }
}

class DeleteDocumentTemplateUseCase {
  final DocumentTemplateService _service;
  
  DeleteDocumentTemplateUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// DocumentTemplate Use Case Container
class DocumentTemplateUseCases {
  final GetDocumentTemplateByIdUseCase getById;
  final GetDocumentTemplatesUseCase getAll;
  final CreateDocumentTemplateUseCase create;
  final UpdateDocumentTemplateUseCase update;
  final DeleteDocumentTemplateUseCase delete;
  
  DocumentTemplateUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory DocumentTemplateUseCases.create(DocumentTemplateService service) {
    return DocumentTemplateUseCases(
      getById: GetDocumentTemplateByIdUseCase(service),
      getAll: GetDocumentTemplatesUseCase(service),
      create: CreateDocumentTemplateUseCase(service),
      update: UpdateDocumentTemplateUseCase(service),
      delete: DeleteDocumentTemplateUseCase(service),
    );
  }
}
