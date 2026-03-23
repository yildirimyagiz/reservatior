import '../../features/shared/services/ai_fraud_detection_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for AIFraudDetection

class GetAIFraudDetectionByIdUseCase {
  final AIFraudDetectionService _service;
  
  GetAIFraudDetectionByIdUseCase(this._service);
  
  Future<AIFraudDetection> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetAIFraudDetectionsUseCase {
  final AIFraudDetectionService _service;
  
  GetAIFraudDetectionsUseCase(this._service);
  
  Future<List<AIFraudDetection>> execute({
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

class CreateAIFraudDetectionUseCase {
  final AIFraudDetectionService _service;
  
  CreateAIFraudDetectionUseCase(this._service);
  
  Future<AIFraudDetection> execute(AIFraudDetection aIFraudDetection) async {
    // Add validation logic here
    return await _service.create(aIFraudDetection);
  }
}

class UpdateAIFraudDetectionUseCase {
  final AIFraudDetectionService _service;
  
  UpdateAIFraudDetectionUseCase(this._service);
  
  Future<AIFraudDetection> execute(String id, AIFraudDetection aIFraudDetection) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, aIFraudDetection);
  }
}

class DeleteAIFraudDetectionUseCase {
  final AIFraudDetectionService _service;
  
  DeleteAIFraudDetectionUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// AIFraudDetection Use Case Container
class AIFraudDetectionUseCases {
  final GetAIFraudDetectionByIdUseCase getById;
  final GetAIFraudDetectionsUseCase getAll;
  final CreateAIFraudDetectionUseCase create;
  final UpdateAIFraudDetectionUseCase update;
  final DeleteAIFraudDetectionUseCase delete;
  
  AIFraudDetectionUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory AIFraudDetectionUseCases.create(AIFraudDetectionService service) {
    return AIFraudDetectionUseCases(
      getById: GetAIFraudDetectionByIdUseCase(service),
      getAll: GetAIFraudDetectionsUseCase(service),
      create: CreateAIFraudDetectionUseCase(service),
      update: UpdateAIFraudDetectionUseCase(service),
      delete: DeleteAIFraudDetectionUseCase(service),
    );
  }
}
