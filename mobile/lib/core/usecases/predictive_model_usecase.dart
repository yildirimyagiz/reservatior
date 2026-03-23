import '../../features/shared/services/predictive_model_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for PredictiveModel

class GetPredictiveModelByIdUseCase {
  final PredictiveModelService _service;
  
  GetPredictiveModelByIdUseCase(this._service);
  
  Future<PredictiveModel> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetPredictiveModelsUseCase {
  final PredictiveModelService _service;
  
  GetPredictiveModelsUseCase(this._service);
  
  Future<List<PredictiveModel>> execute({
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

class CreatePredictiveModelUseCase {
  final PredictiveModelService _service;
  
  CreatePredictiveModelUseCase(this._service);
  
  Future<PredictiveModel> execute(PredictiveModel predictiveModel) async {
    // Add validation logic here
    return await _service.create(predictiveModel);
  }
}

class UpdatePredictiveModelUseCase {
  final PredictiveModelService _service;
  
  UpdatePredictiveModelUseCase(this._service);
  
  Future<PredictiveModel> execute(String id, PredictiveModel predictiveModel) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, predictiveModel);
  }
}

class DeletePredictiveModelUseCase {
  final PredictiveModelService _service;
  
  DeletePredictiveModelUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// PredictiveModel Use Case Container
class PredictiveModelUseCases {
  final GetPredictiveModelByIdUseCase getById;
  final GetPredictiveModelsUseCase getAll;
  final CreatePredictiveModelUseCase create;
  final UpdatePredictiveModelUseCase update;
  final DeletePredictiveModelUseCase delete;
  
  PredictiveModelUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory PredictiveModelUseCases.create(PredictiveModelService service) {
    return PredictiveModelUseCases(
      getById: GetPredictiveModelByIdUseCase(service),
      getAll: GetPredictiveModelsUseCase(service),
      create: CreatePredictiveModelUseCase(service),
      update: UpdatePredictiveModelUseCase(service),
      delete: DeletePredictiveModelUseCase(service),
    );
  }
}
