import 'package:reservatior/shared/repositories/attachment_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetAttachmentByIdUseCase {
  final AttachmentRepository _repository;
  GetAttachmentByIdUseCase(this._repository);
  Future<Attachment> execute(String id) => _repository.getById(id);
}

class GetAttachmentsUseCase {
  final AttachmentRepository _repository;
  GetAttachmentsUseCase(this._repository);
  Future<List<Attachment>> execute({
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

class CreateAttachmentUseCase {
  final AttachmentRepository _repository;
  CreateAttachmentUseCase(this._repository);
  Future<Attachment> execute(Attachment item) => _repository.create(item);
}

class UpdateAttachmentUseCase {
  final AttachmentRepository _repository;
  UpdateAttachmentUseCase(this._repository);
  Future<Attachment> execute(String id, Attachment item) => _repository.update(id, item);
}

class DeleteAttachmentUseCase {
  final AttachmentRepository _repository;
  DeleteAttachmentUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
