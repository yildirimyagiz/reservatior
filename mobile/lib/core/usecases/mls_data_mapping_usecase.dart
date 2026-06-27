import 'package:reservatior/shared/repositories/mls_data_mapping_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetMlsDataMappingByIdUseCase {
  final MlsDataMappingRepository _repository;
  GetMlsDataMappingByIdUseCase(this._repository);
  Future<MlsDataMapping> execute(String id) => _repository.getById(id);
}

class GetMlsDataMappingsUseCase {
  final MlsDataMappingRepository _repository;
  GetMlsDataMappingsUseCase(this._repository);
  Future<List<MlsDataMapping>> execute({
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

class CreateMlsDataMappingUseCase {
  final MlsDataMappingRepository _repository;
  CreateMlsDataMappingUseCase(this._repository);
  Future<MlsDataMapping> execute(MlsDataMapping item) => _repository.create(item);
}

class UpdateMlsDataMappingUseCase {
  final MlsDataMappingRepository _repository;
  UpdateMlsDataMappingUseCase(this._repository);
  Future<MlsDataMapping> execute(String id, MlsDataMapping item) => _repository.update(id, item);
}

class DeleteMlsDataMappingUseCase {
  final MlsDataMappingRepository _repository;
  DeleteMlsDataMappingUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
