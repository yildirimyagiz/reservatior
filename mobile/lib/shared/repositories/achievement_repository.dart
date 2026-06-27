import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/achievement_service.dart';

abstract class AchievementRepository {
  Future<Achievement> getById(String id);
  Future<List<Achievement>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<Achievement> create(Achievement item);
  Future<Achievement> update(String id, Achievement item);
  Future<void> delete(String id);
}

class AchievementRepositoryImpl implements AchievementRepository {
  final AchievementService _service;
  AchievementRepositoryImpl(this._service);

  @override
  Future<Achievement> getById(String id) => _service.getAchievementById(id);

  @override
  Future<List<Achievement>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getAchievements(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<Achievement> create(Achievement item) => _service.createAchievement(item);

  @override
  Future<Achievement> update(String id, Achievement item) => _service.updateAchievement(id, item);

  @override
  Future<void> delete(String id) => _service.deleteAchievement(id);
}
