import '../../features/shared/services/ai_chat_message_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for AIChatMessage

class GetAIChatMessageByIdUseCase {
  final AIChatMessageService _service;
  
  GetAIChatMessageByIdUseCase(this._service);
  
  Future<AIChatMessage> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetAIChatMessagesUseCase {
  final AIChatMessageService _service;
  
  GetAIChatMessagesUseCase(this._service);
  
  Future<List<AIChatMessage>> execute({
    int page = 1,
    int limit = 20,
    Map<String, dynamic>? filters,
  }) async {
    if (page <= 0) {
      throw ArgumentError('Page must be greater than 0');
    }
    if (limit <= 0 || limit > 100) {
      throw ArgumentError('Limit must be between 1 and 100');
    }
    return await _service.getAll(
      page: page,
      limit: limit,
      filters: filters,
    );
  }
}

class CreateAIChatMessageUseCase {
  final AIChatMessageService _service;
  
  CreateAIChatMessageUseCase(this._service);
  
  Future<AIChatMessage> execute(AIChatMessage aIChatMessage) async {
    // Add validation logic here
    return await _service.create(aIChatMessage);
  }
}

class UpdateAIChatMessageUseCase {
  final AIChatMessageService _service;
  
  UpdateAIChatMessageUseCase(this._service);
  
  Future<AIChatMessage> execute(String id, AIChatMessage aIChatMessage) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, aIChatMessage);
  }
}

class DeleteAIChatMessageUseCase {
  final AIChatMessageService _service;
  
  DeleteAIChatMessageUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// AIChatMessage Use Case Container
class AIChatMessageUseCases {
  final GetAIChatMessageByIdUseCase getById;
  final GetAIChatMessagesUseCase getAll;
  final CreateAIChatMessageUseCase create;
  final UpdateAIChatMessageUseCase update;
  final DeleteAIChatMessageUseCase delete;
  
  AIChatMessageUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory AIChatMessageUseCases.create(AIChatMessageService service) {
    return AIChatMessageUseCases(
      getById: GetAIChatMessageByIdUseCase(service),
      getAll: GetAIChatMessagesUseCase(service),
      create: CreateAIChatMessageUseCase(service),
      update: UpdateAIChatMessageUseCase(service),
      delete: DeleteAIChatMessageUseCase(service),
    );
  }
}
