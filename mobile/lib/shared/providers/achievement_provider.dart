import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/achievement_service.dart';
import 'package:reservatior/shared/repositories/achievement_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final achievementServiceProvider = Provider<AchievementService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return AchievementService(dioClient);
});

final achievementRepositoryProvider = Provider<AchievementRepository>((ref) {
  final service = ref.watch(achievementServiceProvider);
  return AchievementRepositoryImpl(service);
});

final achievementListProvider = StateNotifierProvider.autoDispose<AchievementNotifier, AsyncValue<List<Achievement>>>((ref) {
  final repository = ref.watch(achievementRepositoryProvider);
  return AchievementNotifier(repository);
});

class AchievementNotifier extends StateNotifier<AsyncValue<List<Achievement>>> {
  final AchievementRepository _repository;

  AchievementNotifier(this._repository) : super(const AsyncValue.loading()) {
    fetchAchievements();
  }

  Future<void> fetchAchievements() async {
    state = const AsyncValue.loading();
    try {
      final items = await _repository.getAll();
      state = AsyncValue.data(items);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> create(Achievement item) async {
    try {
      await _repository.create(item);
      await fetchAchievements();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateItem(String id, Achievement item) async {
    try {
      await _repository.update(id, item);
      await fetchAchievements();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteItem(String id) async {
    try {
      await _repository.delete(id);
      await fetchAchievements();
    } catch (e) {
      rethrow;
    }
  }
}
