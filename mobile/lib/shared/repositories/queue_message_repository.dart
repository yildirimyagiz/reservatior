import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/queue_message_service.dart';

abstract class QueueMessageRepository {
  Future<QueueMessage> getById(String id);
  Future<List<QueueMessage>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<QueueMessage> create(QueueMessage item);
  Future<QueueMessage> update(String id, QueueMessage item);
  Future<void> delete(String id);
}

class QueueMessageRepositoryImpl implements QueueMessageRepository {
  final QueueMessageService _service;
  QueueMessageRepositoryImpl(this._service);

  @override
  Future<QueueMessage> getById(String id) => _service.getQueueMessageById(id);

  @override
  Future<List<QueueMessage>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getQueueMessages(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<QueueMessage> create(QueueMessage item) => _service.createQueueMessage(item);

  @override
  Future<QueueMessage> update(String id, QueueMessage item) => _service.updateQueueMessage(id, item);

  @override
  Future<void> delete(String id) => _service.deleteQueueMessage(id);
}
