import '../../features/shared/services/agency_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for Agency

class GetAgencyByIdUseCase {
  final AgencyService _service;
  
  GetAgencyByIdUseCase(this._service);
  
  Future<Agency> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetAgencysUseCase {
  final AgencyService _service;
  
  GetAgencysUseCase(this._service);
  
  Future<List<Agency>> execute({
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

class CreateAgencyUseCase {
  final AgencyService _service;
  
  CreateAgencyUseCase(this._service);
  
  Future<Agency> execute(Agency agency) async {
    // Add validation logic here
    return await _service.create(agency);
  }
}

class UpdateAgencyUseCase {
  final AgencyService _service;
  
  UpdateAgencyUseCase(this._service);
  
  Future<Agency> execute(String id, Agency agency) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, agency);
  }
}

class DeleteAgencyUseCase {
  final AgencyService _service;
  
  DeleteAgencyUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// Agency Use Case Container
class AgencyUseCases {
  final GetAgencyByIdUseCase getById;
  final GetAgencysUseCase getAll;
  final CreateAgencyUseCase create;
  final UpdateAgencyUseCase update;
  final DeleteAgencyUseCase delete;
  
  AgencyUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory AgencyUseCases.create(AgencyService service) {
    return AgencyUseCases(
      getById: GetAgencyByIdUseCase(service),
      getAll: GetAgencysUseCase(service),
      create: CreateAgencyUseCase(service),
      update: UpdateAgencyUseCase(service),
      delete: DeleteAgencyUseCase(service),
    );
  }
}
