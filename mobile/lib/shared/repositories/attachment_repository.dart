import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/attachment_service.dart';

abstract class AttachmentRepository {
  Future<Attachment> getById(String id);
  Future<List<Attachment>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<Attachment> create(Attachment item);
  Future<Attachment> update(String id, Attachment item);
  Future<void> delete(String id);
}

class AttachmentRepositoryImpl implements AttachmentRepository {
  final AttachmentService _service;
  AttachmentRepositoryImpl(this._service);

  @override
  Future<Attachment> getById(String id) => _service.getAttachmentById(id);

  @override
  Future<List<Attachment>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getAttachments(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<Attachment> create(Attachment item) => _service.createAttachment(item);

  @override
  Future<Attachment> update(String id, Attachment item) => _service.updateAttachment(id, item);

  @override
  Future<void> delete(String id) => _service.deleteAttachment(id);
}
