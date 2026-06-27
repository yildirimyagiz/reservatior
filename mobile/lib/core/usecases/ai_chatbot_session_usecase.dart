import 'package:reservatior/shared/repositories/ai_chatbot_session_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetAiChatbotSessionByIdUseCase {
  final AiChatbotSessionRepository _repository;
  GetAiChatbotSessionByIdUseCase(this._repository);
  Future<AiChatbotSession> execute(String id) => _repository.getById(id);
}

class GetAiChatbotSessionsUseCase {
  final AiChatbotSessionRepository _repository;
  GetAiChatbotSessionsUseCase(this._repository);
  Future<List<AiChatbotSession>> execute({
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

class CreateAiChatbotSessionUseCase {
  final AiChatbotSessionRepository _repository;
  CreateAiChatbotSessionUseCase(this._repository);
  Future<AiChatbotSession> execute(AiChatbotSession item) => _repository.create(item);
}

class UpdateAiChatbotSessionUseCase {
  final AiChatbotSessionRepository _repository;
  UpdateAiChatbotSessionUseCase(this._repository);
  Future<AiChatbotSession> execute(String id, AiChatbotSession item) => _repository.update(id, item);
}

class DeleteAiChatbotSessionUseCase {
  final AiChatbotSessionRepository _repository;
  DeleteAiChatbotSessionUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
