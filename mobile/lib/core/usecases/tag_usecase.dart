import 'package:reservatior/shared/repositories/tag_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetTagByIdUseCase {
  final TagRepository _repository;
  GetTagByIdUseCase(this._repository);
  Future<Tag> execute(String id) => _repository.getById(id);
}

class GetTagsUseCase {
  final TagRepository _repository;
  GetTagsUseCase(this._repository);
  Future<List<Tag>> execute({
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

class CreateTagUseCase {
  final TagRepository _repository;
  CreateTagUseCase(this._repository);
  Future<Tag> execute(Tag item) => _repository.create(item);
}

class UpdateTagUseCase {
  final TagRepository _repository;
  UpdateTagUseCase(this._repository);
  Future<Tag> execute(String id, Tag item) => _repository.update(id, item);
}

class DeleteTagUseCase {
  final TagRepository _repository;
  DeleteTagUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
