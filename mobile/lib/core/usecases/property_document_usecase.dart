import 'package:reservatior/shared/repositories/property_document_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetPropertyDocumentByIdUseCase {
  final PropertyDocumentRepository _repository;
  GetPropertyDocumentByIdUseCase(this._repository);
  Future<PropertyDocument> execute(String id) => _repository.getById(id);
}

class GetPropertyDocumentsUseCase {
  final PropertyDocumentRepository _repository;
  GetPropertyDocumentsUseCase(this._repository);
  Future<List<PropertyDocument>> execute({
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

class CreatePropertyDocumentUseCase {
  final PropertyDocumentRepository _repository;
  CreatePropertyDocumentUseCase(this._repository);
  Future<PropertyDocument> execute(PropertyDocument item) => _repository.create(item);
}

class UpdatePropertyDocumentUseCase {
  final PropertyDocumentRepository _repository;
  UpdatePropertyDocumentUseCase(this._repository);
  Future<PropertyDocument> execute(String id, PropertyDocument item) => _repository.update(id, item);
}

class DeletePropertyDocumentUseCase {
  final PropertyDocumentRepository _repository;
  DeletePropertyDocumentUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
