import 'package:reservatior/shared/repositories/hashtag_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetHashtagByIdUseCase {
  final HashtagRepository _repository;
  GetHashtagByIdUseCase(this._repository);
  Future<Hashtag> execute(String id) => _repository.getById(id);
}

class GetHashtagsUseCase {
  final HashtagRepository _repository;
  GetHashtagsUseCase(this._repository);
  Future<List<Hashtag>> execute({
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

class CreateHashtagUseCase {
  final HashtagRepository _repository;
  CreateHashtagUseCase(this._repository);
  Future<Hashtag> execute(Hashtag item) => _repository.create(item);
}

class UpdateHashtagUseCase {
  final HashtagRepository _repository;
  UpdateHashtagUseCase(this._repository);
  Future<Hashtag> execute(String id, Hashtag item) => _repository.update(id, item);
}

class DeleteHashtagUseCase {
  final HashtagRepository _repository;
  DeleteHashtagUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
