import '../../features/shared/services/achievement_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for Achievement

class GetAchievementByIdUseCase {
  final AchievementService _service;
  
  GetAchievementByIdUseCase(this._service);
  
  Future<Achievement> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetAchievementsUseCase {
  final AchievementService _service;
  
  GetAchievementsUseCase(this._service);
  
  Future<List<Achievement>> execute({
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

class CreateAchievementUseCase {
  final AchievementService _service;
  
  CreateAchievementUseCase(this._service);
  
  Future<Achievement> execute(Achievement achievement) async {
    // Add validation logic here
    return await _service.create(achievement);
  }
}

class UpdateAchievementUseCase {
  final AchievementService _service;
  
  UpdateAchievementUseCase(this._service);
  
  Future<Achievement> execute(String id, Achievement achievement) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, achievement);
  }
}

class DeleteAchievementUseCase {
  final AchievementService _service;
  
  DeleteAchievementUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// Achievement Use Case Container
class AchievementUseCases {
  final GetAchievementByIdUseCase getById;
  final GetAchievementsUseCase getAll;
  final CreateAchievementUseCase create;
  final UpdateAchievementUseCase update;
  final DeleteAchievementUseCase delete;
  
  AchievementUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory AchievementUseCases.create(AchievementService service) {
    return AchievementUseCases(
      getById: GetAchievementByIdUseCase(service),
      getAll: GetAchievementsUseCase(service),
      create: CreateAchievementUseCase(service),
      update: UpdateAchievementUseCase(service),
      delete: DeleteAchievementUseCase(service),
    );
  }
}
