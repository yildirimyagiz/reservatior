import '../../features/shared/services/attachment_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for Attachment

class GetAttachmentByIdUseCase {
  final AttachmentService _service;
  
  GetAttachmentByIdUseCase(this._service);
  
  Future<Attachment> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetAttachmentsUseCase {
  final AttachmentService _service;
  
  GetAttachmentsUseCase(this._service);
  
  Future<List<Attachment>> execute({
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

class CreateAttachmentUseCase {
  final AttachmentService _service;
  
  CreateAttachmentUseCase(this._service);
  
  Future<Attachment> execute(Attachment attachment) async {
    // Add validation logic here
    return await _service.create(attachment);
  }
}

class UpdateAttachmentUseCase {
  final AttachmentService _service;
  
  UpdateAttachmentUseCase(this._service);
  
  Future<Attachment> execute(String id, Attachment attachment) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, attachment);
  }
}

class DeleteAttachmentUseCase {
  final AttachmentService _service;
  
  DeleteAttachmentUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// Attachment Use Case Container
class AttachmentUseCases {
  final GetAttachmentByIdUseCase getById;
  final GetAttachmentsUseCase getAll;
  final CreateAttachmentUseCase create;
  final UpdateAttachmentUseCase update;
  final DeleteAttachmentUseCase delete;
  
  AttachmentUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory AttachmentUseCases.create(AttachmentService service) {
    return AttachmentUseCases(
      getById: GetAttachmentByIdUseCase(service),
      getAll: GetAttachmentsUseCase(service),
      create: CreateAttachmentUseCase(service),
      update: UpdateAttachmentUseCase(service),
      delete: DeleteAttachmentUseCase(service),
    );
  }
}
