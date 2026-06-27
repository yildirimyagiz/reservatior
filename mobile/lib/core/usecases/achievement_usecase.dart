import 'package:reservatior/shared/repositories/achievement_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetAchievementByIdUseCase {
  final AchievementRepository _repository;
  GetAchievementByIdUseCase(this._repository);
  Future<Achievement> execute(String id) => _repository.getById(id);
}

class GetAchievementsUseCase {
  final AchievementRepository _repository;
  GetAchievementsUseCase(this._repository);
  Future<List<Achievement>> execute({
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

class CreateAchievementUseCase {
  final AchievementRepository _repository;
  CreateAchievementUseCase(this._repository);
  Future<Achievement> execute(Achievement item) => _repository.create(item);
}

class UpdateAchievementUseCase {
  final AchievementRepository _repository;
  UpdateAchievementUseCase(this._repository);
  Future<Achievement> execute(String id, Achievement item) => _repository.update(id, item);
}

class DeleteAchievementUseCase {
  final AchievementRepository _repository;
  DeleteAchievementUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
