import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/ai_chat_message_service.dart';

abstract class AiChatMessageRepository {
  Future<AiChatMessage> getById(String id);
  Future<List<AiChatMessage>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<AiChatMessage> create(AiChatMessage item);
  Future<AiChatMessage> update(String id, AiChatMessage item);
  Future<void> delete(String id);
}

class AiChatMessageRepositoryImpl implements AiChatMessageRepository {
  final AiChatMessageService _service;
  AiChatMessageRepositoryImpl(this._service);

  @override
  Future<AiChatMessage> getById(String id) => _service.getAiChatMessageById(id);

  @override
  Future<List<AiChatMessage>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getAiChatMessages(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<AiChatMessage> create(AiChatMessage item) => _service.createAiChatMessage(item);

  @override
  Future<AiChatMessage> update(String id, AiChatMessage item) => _service.updateAiChatMessage(id, item);

  @override
  Future<void> delete(String id) => _service.deleteAiChatMessage(id);
}
