import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/ai_chatbot_session_service.dart';

abstract class AiChatbotSessionRepository {
  Future<AiChatbotSession> getById(String id);
  Future<List<AiChatbotSession>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<AiChatbotSession> create(AiChatbotSession item);
  Future<AiChatbotSession> update(String id, AiChatbotSession item);
  Future<void> delete(String id);
}

class AiChatbotSessionRepositoryImpl implements AiChatbotSessionRepository {
  final AiChatbotSessionService _service;
  AiChatbotSessionRepositoryImpl(this._service);

  @override
  Future<AiChatbotSession> getById(String id) => _service.getAiChatbotSessionById(id);

  @override
  Future<List<AiChatbotSession>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getAiChatbotSessions(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<AiChatbotSession> create(AiChatbotSession item) => _service.createAiChatbotSession(item);

  @override
  Future<AiChatbotSession> update(String id, AiChatbotSession item) => _service.updateAiChatbotSession(id, item);

  @override
  Future<void> delete(String id) => _service.deleteAiChatbotSession(id);
}
