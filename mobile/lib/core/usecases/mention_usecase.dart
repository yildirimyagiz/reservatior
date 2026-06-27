import 'package:reservatior/shared/repositories/mention_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetMentionByIdUseCase {
  final MentionRepository _repository;
  GetMentionByIdUseCase(this._repository);
  Future<Mention> execute(String id) => _repository.getById(id);
}

class GetMentionsUseCase {
  final MentionRepository _repository;
  GetMentionsUseCase(this._repository);
  Future<List<Mention>> execute({
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

class CreateMentionUseCase {
  final MentionRepository _repository;
  CreateMentionUseCase(this._repository);
  Future<Mention> execute(Mention item) => _repository.create(item);
}

class UpdateMentionUseCase {
  final MentionRepository _repository;
  UpdateMentionUseCase(this._repository);
  Future<Mention> execute(String id, Mention item) => _repository.update(id, item);
}

class DeleteMentionUseCase {
  final MentionRepository _repository;
  DeleteMentionUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
