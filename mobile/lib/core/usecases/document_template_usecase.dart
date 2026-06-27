import 'package:reservatior/shared/repositories/document_template_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetDocumentTemplateByIdUseCase {
  final DocumentTemplateRepository _repository;
  GetDocumentTemplateByIdUseCase(this._repository);
  Future<DocumentTemplate> execute(String id) => _repository.getById(id);
}

class GetDocumentTemplatesUseCase {
  final DocumentTemplateRepository _repository;
  GetDocumentTemplatesUseCase(this._repository);
  Future<List<DocumentTemplate>> execute({
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

class CreateDocumentTemplateUseCase {
  final DocumentTemplateRepository _repository;
  CreateDocumentTemplateUseCase(this._repository);
  Future<DocumentTemplate> execute(DocumentTemplate item) => _repository.create(item);
}

class UpdateDocumentTemplateUseCase {
  final DocumentTemplateRepository _repository;
  UpdateDocumentTemplateUseCase(this._repository);
  Future<DocumentTemplate> execute(String id, DocumentTemplate item) => _repository.update(id, item);
}

class DeleteDocumentTemplateUseCase {
  final DocumentTemplateRepository _repository;
  DeleteDocumentTemplateUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
