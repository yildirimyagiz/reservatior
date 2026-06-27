import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/message_service.dart';

abstract class MessageRepository {
  Future<Message> getById(String id);
  Future<List<Message>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<Message> create(Message item);
  Future<Message> update(String id, Message item);
  Future<void> delete(String id);
  Future<List<Message>> getThreads({int page, int limit, String? orgId});
  Future<List<Message>> getThreadMessages(String threadId);
  Future<Message> replyToThread(String threadId, Message item);
}

class MessageRepositoryImpl implements MessageRepository {
  final MessageService _service;
  MessageRepositoryImpl(this._service);

  @override
  Future<Message> getById(String id) => _service.getMessageById(id);

  @override
  Future<List<Message>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getMessages(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<Message> create(Message item) => _service.createMessage(item);

  @override
  Future<Message> update(String id, Message item) => _service.updateMessage(id, item);

  @override
  Future<void> delete(String id) => _service.deleteMessage(id);

  @override
  Future<List<Message>> getThreads({int page = 1, int limit = 20, String? orgId}) {
    return _service.getThreads(page: page, limit: limit, orgId: orgId);
  }

  @override
  Future<List<Message>> getThreadMessages(String threadId) {
    return _service.getThreadMessages(threadId);
  }

  @override
  Future<Message> replyToThread(String threadId, Message item) {
    return _service.replyToThread(threadId, item);
  }
}
