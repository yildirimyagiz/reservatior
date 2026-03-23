import '../../features/shared/services/ai_price_optimization_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for AIPriceOptimization

class GetAIPriceOptimizationByIdUseCase {
  final AIPriceOptimizationService _service;
  
  GetAIPriceOptimizationByIdUseCase(this._service);
  
  Future<AIPriceOptimization> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetAIPriceOptimizationsUseCase {
  final AIPriceOptimizationService _service;
  
  GetAIPriceOptimizationsUseCase(this._service);
  
  Future<List<AIPriceOptimization>> execute({
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

class CreateAIPriceOptimizationUseCase {
  final AIPriceOptimizationService _service;
  
  CreateAIPriceOptimizationUseCase(this._service);
  
  Future<AIPriceOptimization> execute(AIPriceOptimization aIPriceOptimization) async {
    // Add validation logic here
    return await _service.create(aIPriceOptimization);
  }
}

class UpdateAIPriceOptimizationUseCase {
  final AIPriceOptimizationService _service;
  
  UpdateAIPriceOptimizationUseCase(this._service);
  
  Future<AIPriceOptimization> execute(String id, AIPriceOptimization aIPriceOptimization) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, aIPriceOptimization);
  }
}

class DeleteAIPriceOptimizationUseCase {
  final AIPriceOptimizationService _service;
  
  DeleteAIPriceOptimizationUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// AIPriceOptimization Use Case Container
class AIPriceOptimizationUseCases {
  final GetAIPriceOptimizationByIdUseCase getById;
  final GetAIPriceOptimizationsUseCase getAll;
  final CreateAIPriceOptimizationUseCase create;
  final UpdateAIPriceOptimizationUseCase update;
  final DeleteAIPriceOptimizationUseCase delete;
  
  AIPriceOptimizationUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory AIPriceOptimizationUseCases.create(AIPriceOptimizationService service) {
    return AIPriceOptimizationUseCases(
      getById: GetAIPriceOptimizationByIdUseCase(service),
      getAll: GetAIPriceOptimizationsUseCase(service),
      create: CreateAIPriceOptimizationUseCase(service),
      update: UpdateAIPriceOptimizationUseCase(service),
      delete: DeleteAIPriceOptimizationUseCase(service),
    );
  }
}
