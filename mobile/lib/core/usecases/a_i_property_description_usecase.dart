import '../../features/shared/services/ai_property_description_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for AIPropertyDescription

class GetAIPropertyDescriptionByIdUseCase {
  final AIPropertyDescriptionService _service;
  
  GetAIPropertyDescriptionByIdUseCase(this._service);
  
  Future<AIPropertyDescription> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetAIPropertyDescriptionsUseCase {
  final AIPropertyDescriptionService _service;
  
  GetAIPropertyDescriptionsUseCase(this._service);
  
  Future<List<AIPropertyDescription>> execute({
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

class CreateAIPropertyDescriptionUseCase {
  final AIPropertyDescriptionService _service;
  
  CreateAIPropertyDescriptionUseCase(this._service);
  
  Future<AIPropertyDescription> execute(AIPropertyDescription aIPropertyDescription) async {
    // Add validation logic here
    return await _service.create(aIPropertyDescription);
  }
}

class UpdateAIPropertyDescriptionUseCase {
  final AIPropertyDescriptionService _service;
  
  UpdateAIPropertyDescriptionUseCase(this._service);
  
  Future<AIPropertyDescription> execute(String id, AIPropertyDescription aIPropertyDescription) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, aIPropertyDescription);
  }
}

class DeleteAIPropertyDescriptionUseCase {
  final AIPropertyDescriptionService _service;
  
  DeleteAIPropertyDescriptionUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// AIPropertyDescription Use Case Container
class AIPropertyDescriptionUseCases {
  final GetAIPropertyDescriptionByIdUseCase getById;
  final GetAIPropertyDescriptionsUseCase getAll;
  final CreateAIPropertyDescriptionUseCase create;
  final UpdateAIPropertyDescriptionUseCase update;
  final DeleteAIPropertyDescriptionUseCase delete;
  
  AIPropertyDescriptionUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory AIPropertyDescriptionUseCases.create(AIPropertyDescriptionService service) {
    return AIPropertyDescriptionUseCases(
      getById: GetAIPropertyDescriptionByIdUseCase(service),
      getAll: GetAIPropertyDescriptionsUseCase(service),
      create: CreateAIPropertyDescriptionUseCase(service),
      update: UpdateAIPropertyDescriptionUseCase(service),
      delete: DeleteAIPropertyDescriptionUseCase(service),
    );
  }
}
