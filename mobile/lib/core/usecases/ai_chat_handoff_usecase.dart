import 'package:reservatior/shared/repositories/ai_chat_handoff_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetAiChatHandoffByIdUseCase {
  final AiChatHandoffRepository _repository;
  GetAiChatHandoffByIdUseCase(this._repository);
  Future<AiChatHandoff> execute(String id) => _repository.getById(id);
}

class GetAiChatHandoffsUseCase {
  final AiChatHandoffRepository _repository;
  GetAiChatHandoffsUseCase(this._repository);
  Future<List<AiChatHandoff>> execute({
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

class CreateAiChatHandoffUseCase {
  final AiChatHandoffRepository _repository;
  CreateAiChatHandoffUseCase(this._repository);
  Future<AiChatHandoff> execute(AiChatHandoff item) => _repository.create(item);
}

class UpdateAiChatHandoffUseCase {
  final AiChatHandoffRepository _repository;
  UpdateAiChatHandoffUseCase(this._repository);
  Future<AiChatHandoff> execute(String id, AiChatHandoff item) => _repository.update(id, item);
}

class DeleteAiChatHandoffUseCase {
  final AiChatHandoffRepository _repository;
  DeleteAiChatHandoffUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
