import '../../features/shared/services/communication_log_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for CommunicationLog

class GetCommunicationLogByIdUseCase {
  final CommunicationLogService _service;
  
  GetCommunicationLogByIdUseCase(this._service);
  
  Future<CommunicationLog> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetCommunicationLogsUseCase {
  final CommunicationLogService _service;
  
  GetCommunicationLogsUseCase(this._service);
  
  Future<List<CommunicationLog>> execute({
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

class CreateCommunicationLogUseCase {
  final CommunicationLogService _service;
  
  CreateCommunicationLogUseCase(this._service);
  
  Future<CommunicationLog> execute(CommunicationLog communicationLog) async {
    // Add validation logic here
    return await _service.create(communicationLog);
  }
}

class UpdateCommunicationLogUseCase {
  final CommunicationLogService _service;
  
  UpdateCommunicationLogUseCase(this._service);
  
  Future<CommunicationLog> execute(String id, CommunicationLog communicationLog) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, communicationLog);
  }
}

class DeleteCommunicationLogUseCase {
  final CommunicationLogService _service;
  
  DeleteCommunicationLogUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// CommunicationLog Use Case Container
class CommunicationLogUseCases {
  final GetCommunicationLogByIdUseCase getById;
  final GetCommunicationLogsUseCase getAll;
  final CreateCommunicationLogUseCase create;
  final UpdateCommunicationLogUseCase update;
  final DeleteCommunicationLogUseCase delete;
  
  CommunicationLogUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory CommunicationLogUseCases.create(CommunicationLogService service) {
    return CommunicationLogUseCases(
      getById: GetCommunicationLogByIdUseCase(service),
      getAll: GetCommunicationLogsUseCase(service),
      create: CreateCommunicationLogUseCase(service),
      update: UpdateCommunicationLogUseCase(service),
      delete: DeleteCommunicationLogUseCase(service),
    );
  }
}
