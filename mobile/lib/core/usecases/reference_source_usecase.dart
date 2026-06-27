import 'package:reservatior/shared/repositories/reference_source_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetReferenceSourceByIdUseCase {
  final ReferenceSourceRepository _repository;
  GetReferenceSourceByIdUseCase(this._repository);
  Future<ReferenceSource> execute(String id) => _repository.getById(id);
}

class GetReferenceSourcesUseCase {
  final ReferenceSourceRepository _repository;
  GetReferenceSourcesUseCase(this._repository);
  Future<List<ReferenceSource>> execute({
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

class CreateReferenceSourceUseCase {
  final ReferenceSourceRepository _repository;
  CreateReferenceSourceUseCase(this._repository);
  Future<ReferenceSource> execute(ReferenceSource item) => _repository.create(item);
}

class UpdateReferenceSourceUseCase {
  final ReferenceSourceRepository _repository;
  UpdateReferenceSourceUseCase(this._repository);
  Future<ReferenceSource> execute(String id, ReferenceSource item) => _repository.update(id, item);
}

class DeleteReferenceSourceUseCase {
  final ReferenceSourceRepository _repository;
  DeleteReferenceSourceUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
