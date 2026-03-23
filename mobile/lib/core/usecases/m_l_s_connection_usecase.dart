import '../../features/shared/services/m_l_s_connection_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for MLSConnection

class GetMLSConnectionByIdUseCase {
  final MLSConnectionService _service;
  
  GetMLSConnectionByIdUseCase(this._service);
  
  Future<MLSConnection> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetMLSConnectionsUseCase {
  final MLSConnectionService _service;
  
  GetMLSConnectionsUseCase(this._service);
  
  Future<List<MLSConnection>> execute({
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

class CreateMLSConnectionUseCase {
  final MLSConnectionService _service;
  
  CreateMLSConnectionUseCase(this._service);
  
  Future<MLSConnection> execute(MLSConnection mLSConnection) async {
    // Add validation logic here
    return await _service.create(mLSConnection);
  }
}

class UpdateMLSConnectionUseCase {
  final MLSConnectionService _service;
  
  UpdateMLSConnectionUseCase(this._service);
  
  Future<MLSConnection> execute(String id, MLSConnection mLSConnection) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, mLSConnection);
  }
}

class DeleteMLSConnectionUseCase {
  final MLSConnectionService _service;
  
  DeleteMLSConnectionUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// MLSConnection Use Case Container
class MLSConnectionUseCases {
  final GetMLSConnectionByIdUseCase getById;
  final GetMLSConnectionsUseCase getAll;
  final CreateMLSConnectionUseCase create;
  final UpdateMLSConnectionUseCase update;
  final DeleteMLSConnectionUseCase delete;
  
  MLSConnectionUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory MLSConnectionUseCases.create(MLSConnectionService service) {
    return MLSConnectionUseCases(
      getById: GetMLSConnectionByIdUseCase(service),
      getAll: GetMLSConnectionsUseCase(service),
      create: CreateMLSConnectionUseCase(service),
      update: UpdateMLSConnectionUseCase(service),
      delete: DeleteMLSConnectionUseCase(service),
    );
  }
}
