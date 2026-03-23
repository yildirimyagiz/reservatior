import '../../features/shared/services/property_document_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for PropertyDocument

class GetPropertyDocumentByIdUseCase {
  final PropertyDocumentService _service;
  
  GetPropertyDocumentByIdUseCase(this._service);
  
  Future<PropertyDocument> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetPropertyDocumentsUseCase {
  final PropertyDocumentService _service;
  
  GetPropertyDocumentsUseCase(this._service);
  
  Future<List<PropertyDocument>> execute({
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

class CreatePropertyDocumentUseCase {
  final PropertyDocumentService _service;
  
  CreatePropertyDocumentUseCase(this._service);
  
  Future<PropertyDocument> execute(PropertyDocument propertyDocument) async {
    // Add validation logic here
    return await _service.create(propertyDocument);
  }
}

class UpdatePropertyDocumentUseCase {
  final PropertyDocumentService _service;
  
  UpdatePropertyDocumentUseCase(this._service);
  
  Future<PropertyDocument> execute(String id, PropertyDocument propertyDocument) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, propertyDocument);
  }
}

class DeletePropertyDocumentUseCase {
  final PropertyDocumentService _service;
  
  DeletePropertyDocumentUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// PropertyDocument Use Case Container
class PropertyDocumentUseCases {
  final GetPropertyDocumentByIdUseCase getById;
  final GetPropertyDocumentsUseCase getAll;
  final CreatePropertyDocumentUseCase create;
  final UpdatePropertyDocumentUseCase update;
  final DeletePropertyDocumentUseCase delete;
  
  PropertyDocumentUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory PropertyDocumentUseCases.create(PropertyDocumentService service) {
    return PropertyDocumentUseCases(
      getById: GetPropertyDocumentByIdUseCase(service),
      getAll: GetPropertyDocumentsUseCase(service),
      create: CreatePropertyDocumentUseCase(service),
      update: UpdatePropertyDocumentUseCase(service),
      delete: DeletePropertyDocumentUseCase(service),
    );
  }
}
