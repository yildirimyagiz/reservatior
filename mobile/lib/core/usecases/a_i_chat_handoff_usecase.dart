import '../../features/shared/services/ai_chat_handoff_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for AIChatHandoff

class GetAIChatHandoffByIdUseCase {
  final AIChatHandoffService _service;
  
  GetAIChatHandoffByIdUseCase(this._service);
  
  Future<AIChatHandoff> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetAIChatHandoffsUseCase {
  final AIChatHandoffService _service;
  
  GetAIChatHandoffsUseCase(this._service);
  
  Future<List<AIChatHandoff>> execute({
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

class CreateAIChatHandoffUseCase {
  final AIChatHandoffService _service;
  
  CreateAIChatHandoffUseCase(this._service);
  
  Future<AIChatHandoff> execute(AIChatHandoff aIChatHandoff) async {
    // Add validation logic here
    return await _service.create(aIChatHandoff);
  }
}

class UpdateAIChatHandoffUseCase {
  final AIChatHandoffService _service;
  
  UpdateAIChatHandoffUseCase(this._service);
  
  Future<AIChatHandoff> execute(String id, AIChatHandoff aIChatHandoff) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, aIChatHandoff);
  }
}

class DeleteAIChatHandoffUseCase {
  final AIChatHandoffService _service;
  
  DeleteAIChatHandoffUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// AIChatHandoff Use Case Container
class AIChatHandoffUseCases {
  final GetAIChatHandoffByIdUseCase getById;
  final GetAIChatHandoffsUseCase getAll;
  final CreateAIChatHandoffUseCase create;
  final UpdateAIChatHandoffUseCase update;
  final DeleteAIChatHandoffUseCase delete;
  
  AIChatHandoffUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory AIChatHandoffUseCases.create(AIChatHandoffService service) {
    return AIChatHandoffUseCases(
      getById: GetAIChatHandoffByIdUseCase(service),
      getAll: GetAIChatHandoffsUseCase(service),
      create: CreateAIChatHandoffUseCase(service),
      update: UpdateAIChatHandoffUseCase(service),
      delete: DeleteAIChatHandoffUseCase(service),
    );
  }
}
