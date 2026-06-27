import 'package:reservatior/shared/repositories/ai_chat_message_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetAiChatMessageByIdUseCase {
  final AiChatMessageRepository _repository;
  GetAiChatMessageByIdUseCase(this._repository);
  Future<AiChatMessage> execute(String id) => _repository.getById(id);
}

class GetAiChatMessagesUseCase {
  final AiChatMessageRepository _repository;
  GetAiChatMessagesUseCase(this._repository);
  Future<List<AiChatMessage>> execute({
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

class CreateAiChatMessageUseCase {
  final AiChatMessageRepository _repository;
  CreateAiChatMessageUseCase(this._repository);
  Future<AiChatMessage> execute(AiChatMessage item) => _repository.create(item);
}

class UpdateAiChatMessageUseCase {
  final AiChatMessageRepository _repository;
  UpdateAiChatMessageUseCase(this._repository);
  Future<AiChatMessage> execute(String id, AiChatMessage item) => _repository.update(id, item);
}

class DeleteAiChatMessageUseCase {
  final AiChatMessageRepository _repository;
  DeleteAiChatMessageUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
