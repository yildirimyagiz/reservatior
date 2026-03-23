import '../../features/shared/services/lead_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for Lead

class GetLeadByIdUseCase {
  final LeadService _service;
  
  GetLeadByIdUseCase(this._service);
  
  Future<Lead> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetLeadsUseCase {
  final LeadService _service;
  
  GetLeadsUseCase(this._service);
  
  Future<List<Lead>> execute({
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

class CreateLeadUseCase {
  final LeadService _service;
  
  CreateLeadUseCase(this._service);
  
  Future<Lead> execute(Lead lead) async {
    // Add validation logic here
    return await _service.create(lead);
  }
}

class UpdateLeadUseCase {
  final LeadService _service;
  
  UpdateLeadUseCase(this._service);
  
  Future<Lead> execute(String id, Lead lead) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, lead);
  }
}

class DeleteLeadUseCase {
  final LeadService _service;
  
  DeleteLeadUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// Lead Use Case Container
class LeadUseCases {
  final GetLeadByIdUseCase getById;
  final GetLeadsUseCase getAll;
  final CreateLeadUseCase create;
  final UpdateLeadUseCase update;
  final DeleteLeadUseCase delete;
  
  LeadUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory LeadUseCases.create(LeadService service) {
    return LeadUseCases(
      getById: GetLeadByIdUseCase(service),
      getAll: GetLeadsUseCase(service),
      create: CreateLeadUseCase(service),
      update: UpdateLeadUseCase(service),
      delete: DeleteLeadUseCase(service),
    );
  }
}
