import '../../features/shared/services/lead_source_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for LeadSource

class GetLeadSourceByIdUseCase {
  final LeadSourceService _service;
  
  GetLeadSourceByIdUseCase(this._service);
  
  Future<LeadSource> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetLeadSourcesUseCase {
  final LeadSourceService _service;
  
  GetLeadSourcesUseCase(this._service);
  
  Future<List<LeadSource>> execute({
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

class CreateLeadSourceUseCase {
  final LeadSourceService _service;
  
  CreateLeadSourceUseCase(this._service);
  
  Future<LeadSource> execute(LeadSource leadSource) async {
    // Add validation logic here
    return await _service.create(leadSource);
  }
}

class UpdateLeadSourceUseCase {
  final LeadSourceService _service;
  
  UpdateLeadSourceUseCase(this._service);
  
  Future<LeadSource> execute(String id, LeadSource leadSource) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, leadSource);
  }
}

class DeleteLeadSourceUseCase {
  final LeadSourceService _service;
  
  DeleteLeadSourceUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// LeadSource Use Case Container
class LeadSourceUseCases {
  final GetLeadSourceByIdUseCase getById;
  final GetLeadSourcesUseCase getAll;
  final CreateLeadSourceUseCase create;
  final UpdateLeadSourceUseCase update;
  final DeleteLeadSourceUseCase delete;
  
  LeadSourceUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory LeadSourceUseCases.create(LeadSourceService service) {
    return LeadSourceUseCases(
      getById: GetLeadSourceByIdUseCase(service),
      getAll: GetLeadSourcesUseCase(service),
      create: CreateLeadSourceUseCase(service),
      update: UpdateLeadSourceUseCase(service),
      delete: DeleteLeadSourceUseCase(service),
    );
  }
}
