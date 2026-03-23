import '../../features/shared/services/included_service_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for IncludedService

class GetIncludedServiceByIdUseCase {
  final IncludedServiceService _service;
  
  GetIncludedServiceByIdUseCase(this._service);
  
  Future<IncludedService> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetIncludedServicesUseCase {
  final IncludedServiceService _service;
  
  GetIncludedServicesUseCase(this._service);
  
  Future<List<IncludedService>> execute({
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

class CreateIncludedServiceUseCase {
  final IncludedServiceService _service;
  
  CreateIncludedServiceUseCase(this._service);
  
  Future<IncludedService> execute(IncludedService includedService) async {
    // Add validation logic here
    return await _service.create(includedService);
  }
}

class UpdateIncludedServiceUseCase {
  final IncludedServiceService _service;
  
  UpdateIncludedServiceUseCase(this._service);
  
  Future<IncludedService> execute(String id, IncludedService includedService) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, includedService);
  }
}

class DeleteIncludedServiceUseCase {
  final IncludedServiceService _service;
  
  DeleteIncludedServiceUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// IncludedService Use Case Container
class IncludedServiceUseCases {
  final GetIncludedServiceByIdUseCase getById;
  final GetIncludedServicesUseCase getAll;
  final CreateIncludedServiceUseCase create;
  final UpdateIncludedServiceUseCase update;
  final DeleteIncludedServiceUseCase delete;
  
  IncludedServiceUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory IncludedServiceUseCases.create(IncludedServiceService service) {
    return IncludedServiceUseCases(
      getById: GetIncludedServiceByIdUseCase(service),
      getAll: GetIncludedServicesUseCase(service),
      create: CreateIncludedServiceUseCase(service),
      update: UpdateIncludedServiceUseCase(service),
      delete: DeleteIncludedServiceUseCase(service),
    );
  }
}
