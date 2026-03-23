import '../../features/shared/services/ai_prediction_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for AIPrediction

class GetAIPredictionByIdUseCase {
  final AIPredictionService _service;
  
  GetAIPredictionByIdUseCase(this._service);
  
  Future<AIPrediction> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetAIPredictionsUseCase {
  final AIPredictionService _service;
  
  GetAIPredictionsUseCase(this._service);
  
  Future<List<AIPrediction>> execute({
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

class CreateAIPredictionUseCase {
  final AIPredictionService _service;
  
  CreateAIPredictionUseCase(this._service);
  
  Future<AIPrediction> execute(AIPrediction aIPrediction) async {
    // Add validation logic here
    return await _service.create(aIPrediction);
  }
}

class UpdateAIPredictionUseCase {
  final AIPredictionService _service;
  
  UpdateAIPredictionUseCase(this._service);
  
  Future<AIPrediction> execute(String id, AIPrediction aIPrediction) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, aIPrediction);
  }
}

class DeleteAIPredictionUseCase {
  final AIPredictionService _service;
  
  DeleteAIPredictionUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// AIPrediction Use Case Container
class AIPredictionUseCases {
  final GetAIPredictionByIdUseCase getById;
  final GetAIPredictionsUseCase getAll;
  final CreateAIPredictionUseCase create;
  final UpdateAIPredictionUseCase update;
  final DeleteAIPredictionUseCase delete;
  
  AIPredictionUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory AIPredictionUseCases.create(AIPredictionService service) {
    return AIPredictionUseCases(
      getById: GetAIPredictionByIdUseCase(service),
      getAll: GetAIPredictionsUseCase(service),
      create: CreateAIPredictionUseCase(service),
      update: UpdateAIPredictionUseCase(service),
      delete: DeleteAIPredictionUseCase(service),
    );
  }
}
