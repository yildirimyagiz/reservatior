import '../../features/shared/services/m_l_configuration_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for MLConfiguration

class GetMLConfigurationByIdUseCase {
  final MLConfigurationService _service;
  
  GetMLConfigurationByIdUseCase(this._service);
  
  Future<MLConfiguration> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetMLConfigurationsUseCase {
  final MLConfigurationService _service;
  
  GetMLConfigurationsUseCase(this._service);
  
  Future<List<MLConfiguration>> execute({
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

class CreateMLConfigurationUseCase {
  final MLConfigurationService _service;
  
  CreateMLConfigurationUseCase(this._service);
  
  Future<MLConfiguration> execute(MLConfiguration mLConfiguration) async {
    // Add validation logic here
    return await _service.create(mLConfiguration);
  }
}

class UpdateMLConfigurationUseCase {
  final MLConfigurationService _service;
  
  UpdateMLConfigurationUseCase(this._service);
  
  Future<MLConfiguration> execute(String id, MLConfiguration mLConfiguration) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, mLConfiguration);
  }
}

class DeleteMLConfigurationUseCase {
  final MLConfigurationService _service;
  
  DeleteMLConfigurationUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// MLConfiguration Use Case Container
class MLConfigurationUseCases {
  final GetMLConfigurationByIdUseCase getById;
  final GetMLConfigurationsUseCase getAll;
  final CreateMLConfigurationUseCase create;
  final UpdateMLConfigurationUseCase update;
  final DeleteMLConfigurationUseCase delete;
  
  MLConfigurationUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory MLConfigurationUseCases.create(MLConfigurationService service) {
    return MLConfigurationUseCases(
      getById: GetMLConfigurationByIdUseCase(service),
      getAll: GetMLConfigurationsUseCase(service),
      create: CreateMLConfigurationUseCase(service),
      update: UpdateMLConfigurationUseCase(service),
      delete: DeleteMLConfigurationUseCase(service),
    );
  }
}
