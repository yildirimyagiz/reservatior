import '../../features/shared/services/ai_chatbot_session_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for AIChatbotSession

class GetAIChatbotSessionByIdUseCase {
  final AIChatbotSessionService _service;
  
  GetAIChatbotSessionByIdUseCase(this._service);
  
  Future<AIChatbotSession> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetAIChatbotSessionsUseCase {
  final AIChatbotSessionService _service;
  
  GetAIChatbotSessionsUseCase(this._service);
  
  Future<List<AIChatbotSession>> execute({
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

class CreateAIChatbotSessionUseCase {
  final AIChatbotSessionService _service;
  
  CreateAIChatbotSessionUseCase(this._service);
  
  Future<AIChatbotSession> execute(AIChatbotSession aIChatbotSession) async {
    // Add validation logic here
    return await _service.create(aIChatbotSession);
  }
}

class UpdateAIChatbotSessionUseCase {
  final AIChatbotSessionService _service;
  
  UpdateAIChatbotSessionUseCase(this._service);
  
  Future<AIChatbotSession> execute(String id, AIChatbotSession aIChatbotSession) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, aIChatbotSession);
  }
}

class DeleteAIChatbotSessionUseCase {
  final AIChatbotSessionService _service;
  
  DeleteAIChatbotSessionUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// AIChatbotSession Use Case Container
class AIChatbotSessionUseCases {
  final GetAIChatbotSessionByIdUseCase getById;
  final GetAIChatbotSessionsUseCase getAll;
  final CreateAIChatbotSessionUseCase create;
  final UpdateAIChatbotSessionUseCase update;
  final DeleteAIChatbotSessionUseCase delete;
  
  AIChatbotSessionUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory AIChatbotSessionUseCases.create(AIChatbotSessionService service) {
    return AIChatbotSessionUseCases(
      getById: GetAIChatbotSessionByIdUseCase(service),
      getAll: GetAIChatbotSessionsUseCase(service),
      create: CreateAIChatbotSessionUseCase(service),
      update: UpdateAIChatbotSessionUseCase(service),
      delete: DeleteAIChatbotSessionUseCase(service),
    );
  }
}
