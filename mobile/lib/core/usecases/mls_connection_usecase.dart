import 'package:reservatior/shared/repositories/mls_connection_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetMlsConnectionByIdUseCase {
  final MlsConnectionRepository _repository;
  GetMlsConnectionByIdUseCase(this._repository);
  Future<MlsConnection> execute(String id) => _repository.getById(id);
}

class GetMlsConnectionsUseCase {
  final MlsConnectionRepository _repository;
  GetMlsConnectionsUseCase(this._repository);
  Future<List<MlsConnection>> execute({
    int page = 1, 
    int limit = 20, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) => _repository.getAll(
    page: page, 
    limit: limit, 
    filters: filters,
    sortBy: sortBy,
    sortOrder: sortOrder,
  );
}

class CreateMlsConnectionUseCase {
  final MlsConnectionRepository _repository;
  CreateMlsConnectionUseCase(this._repository);
  Future<MlsConnection> execute(MlsConnection item) => _repository.create(item);
}

class UpdateMlsConnectionUseCase {
  final MlsConnectionRepository _repository;
  UpdateMlsConnectionUseCase(this._repository);
  Future<MlsConnection> execute(String id, MlsConnection item) => _repository.update(id, item);
}

class DeleteMlsConnectionUseCase {
  final MlsConnectionRepository _repository;
  DeleteMlsConnectionUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
