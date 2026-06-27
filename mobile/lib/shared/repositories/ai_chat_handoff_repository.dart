import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/ai_chat_handoff_service.dart';

abstract class AiChatHandoffRepository {
  Future<AiChatHandoff> getById(String id);
  Future<List<AiChatHandoff>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<AiChatHandoff> create(AiChatHandoff item);
  Future<AiChatHandoff> update(String id, AiChatHandoff item);
  Future<void> delete(String id);
}

class AiChatHandoffRepositoryImpl implements AiChatHandoffRepository {
  final AiChatHandoffService _service;
  AiChatHandoffRepositoryImpl(this._service);

  @override
  Future<AiChatHandoff> getById(String id) => _service.getAiChatHandoffById(id);

  @override
  Future<List<AiChatHandoff>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getAiChatHandoffs(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<AiChatHandoff> create(AiChatHandoff item) => _service.createAiChatHandoff(item);

  @override
  Future<AiChatHandoff> update(String id, AiChatHandoff item) => _service.updateAiChatHandoff(id, item);

  @override
  Future<void> delete(String id) => _service.deleteAiChatHandoff(id);
}
