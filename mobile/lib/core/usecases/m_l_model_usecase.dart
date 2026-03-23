import '../../features/shared/services/m_l_model_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for MLModel

class GetMLModelByIdUseCase {
  final MLModelService _service;
  
  GetMLModelByIdUseCase(this._service);
  
  Future<MLModel> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetMLModelsUseCase {
  final MLModelService _service;
  
  GetMLModelsUseCase(this._service);
  
  Future<List<MLModel>> execute({
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

class CreateMLModelUseCase {
  final MLModelService _service;
  
  CreateMLModelUseCase(this._service);
  
  Future<MLModel> execute(MLModel mLModel) async {
    // Add validation logic here
    return await _service.create(mLModel);
  }
}

class UpdateMLModelUseCase {
  final MLModelService _service;
  
  UpdateMLModelUseCase(this._service);
  
  Future<MLModel> execute(String id, MLModel mLModel) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, mLModel);
  }
}

class DeleteMLModelUseCase {
  final MLModelService _service;
  
  DeleteMLModelUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// MLModel Use Case Container
class MLModelUseCases {
  final GetMLModelByIdUseCase getById;
  final GetMLModelsUseCase getAll;
  final CreateMLModelUseCase create;
  final UpdateMLModelUseCase update;
  final DeleteMLModelUseCase delete;
  
  MLModelUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory MLModelUseCases.create(MLModelService service) {
    return MLModelUseCases(
      getById: GetMLModelByIdUseCase(service),
      getAll: GetMLModelsUseCase(service),
      create: CreateMLModelUseCase(service),
      update: UpdateMLModelUseCase(service),
      delete: DeleteMLModelUseCase(service),
    );
  }
}
