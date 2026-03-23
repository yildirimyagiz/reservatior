import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../gen_models/models_library.dart';
import '../../../shared/services/achievement_service.dart';
import '../../../core/error/service_exception.dart';
import 'achievement_state.dart';

/// Notifier for achievement list management
class AchievementListNotifier extends StateNotifier<AchievementListState> {
  final AchievementService _service;
  
  AchievementListNotifier(this._service) : super(const AchievementListState.initial());

  /// Load achievements with pagination
  Future<void> loadAchievements({
    int page = 1,
    int limit = 20,
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) async {
    state = const AchievementListState.loading();
    
    try {
      final achievements = await _service.getAchievements(
        page: page,
        limit: limit,
        filters: filters,
        sortBy: sortBy,
        sortOrder: sortOrder,
      );
      
      state = AchievementListState.loaded(
        achievements,
        currentPage: page,
        hasMore: achievements.length >= limit,
        total: achievements.length,
      );
    } on ServiceException catch (e) {
      state = AchievementListState.error(e.message);
    } catch (e) {
      state = AchievementListState.error('An unexpected error occurred');
    }
  }

  /// Load user achievements
  Future<void> loadUserAchievements(String userId, {bool? unlocked}) async {
    state = const AchievementListState.loading();
    
    try {
      final achievements = await _service.getUserAchievements(userId, unlocked: unlocked);
      
      state = AchievementListState.loaded(
        achievements,
        currentPage: 1,
        hasMore: false,
        total: achievements.length,
      );
    } on ServiceException catch (e) {
      state = AchievementListState.error(e.message);
    } catch (e) {
      state = AchievementListState.error('Failed to load user achievements');
    }
  }

  /// Load more achievements (pagination)
  Future<void> loadMore({
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) async {
    state.whenOrNull(
      loaded: (achievements, currentPage, hasMore, total) async {
        if (!hasMore) return;
        
        try {
          final newAchievements = await _service.getAchievements(
            page: currentPage + 1,
            filters: filters,
            sortBy: sortBy,
            sortOrder: sortOrder,
          );
          
          state = AchievementListState.loaded(
            [...achievements, ...newAchievements],
            currentPage: currentPage + 1,
            hasMore: newAchievements.isNotEmpty,
            total: total + newAchievements.length,
          );
        } on ServiceException catch (e) {
          state = AchievementListState.error(e.message);
        }
      },
    );
  }

  /// Search achievements
  Future<void> searchAchievements(String query, {int page = 1}) async {
    state = const AchievementListState.loading();
    
    try {
      final achievements = await _service.searchAchievements(
        query: query,
        page: page,
      );
      
      state = AchievementListState.loaded(
        achievements,
        currentPage: page,
        hasMore: achievements.length >= 20,
        total: achievements.length,
      );
    } on ServiceException catch (e) {
      state = AchievementListState.error(e.message);
    } catch (e) {
      state = AchievementListState.error('Search failed');
    }
  }

  /// Refresh achievements
  Future<void> refresh() async {
    await loadAchievements();
  }
}

/// Notifier for single achievement management
class AchievementNotifier extends StateNotifier<AchievementState> {
  final AchievementService _service;
  
  AchievementNotifier(this._service) : super(const AchievementState.initial());

  /// Load achievement by ID
  Future<void> loadAchievement(String id) async {
    state = const AchievementState.loading();
    
    try {
      final achievement = await _service.getAchievementById(id);
      state = AchievementState.loaded(achievement);
    } on ServiceException catch (e) {
      state = AchievementState.error(e.message);
    } catch (e) {
      state = AchievementState.error('Failed to load achievement');
    }
  }

  /// Create new achievement
  Future<bool> createAchievement(Achievement achievement) async {
    state = const AchievementState.loading();
    
    try {
      final created = await _service.createAchievement(achievement);
      state = AchievementState.loaded(created);
      return true;
    } on ServiceException catch (e) {
      state = AchievementState.error(e.message);
      return false;
    } catch (e) {
      state = AchievementState.error('Failed to create achievement');
      return false;
    }
  }

  /// Update achievement
  Future<bool> updateAchievement(String id, Achievement achievement) async {
    state = const AchievementState.loading();
    
    try {
      final updated = await _service.updateAchievement(id, achievement);
      state = AchievementState.loaded(updated);
      return true;
    } on ServiceException catch (e) {
      state = AchievementState.error(e.message);
      return false;
    } catch (e) {
      state = AchievementState.error('Failed to update achievement');
      return false;
    }
  }

  /// Delete achievement
  Future<bool> deleteAchievement(String id) async {
    state = const AchievementState.loading();
    
    try {
      await _service.deleteAchievement(id);
      state = const AchievementState.initial();
      return true;
    } on ServiceException catch (e) {
      state = AchievementState.error(e.message);
      return false;
    } catch (e) {
      state = AchievementState.error('Failed to delete achievement');
      return false;
    }
  }

  /// Clear state
  void clear() {
    state = const AchievementState.initial();
  }
}

/// Notifier for achievement statistics
class AchievementStatsNotifier extends StateNotifier<AchievementStatsState> {
  final AchievementService _service;
  
  AchievementStatsNotifier(this._service) : super(const AchievementStatsState.initial());

  /// Load user statistics
  Future<void> loadUserStats(String userId) async {
    state = const AchievementStatsState.loading();
    
    try {
      final stats = await _service.getUserStats(userId);
      state = AchievementStatsState.loaded(stats);
    } on ServiceException catch (e) {
      state = AchievementStatsState.error(e.message);
    } catch (e) {
      state = AchievementStatsState.error('Failed to load statistics');
    }
  }

  /// Load global statistics
  Future<void> loadGlobalStats() async {
    state = const AchievementStatsState.loading();
    
    try {
      final stats = await _service.getGlobalStats();
      state = AchievementStatsState.loaded(stats);
    } on ServiceException catch (e) {
      state = AchievementStatsState.error(e.message);
    } catch (e) {
      state = AchievementStatsState.error('Failed to load statistics');
    }
  }

  /// Refresh statistics
  Future<void> refresh(String? userId) async {
    if (userId != null) {
      await loadUserStats(userId);
    } else {
      await loadGlobalStats();
    }
  }
}

/// Notifier for leaderboard
class LeaderboardNotifier extends StateNotifier<LeaderboardState> {
  final AchievementService _service;
  
  LeaderboardNotifier(this._service) : super(const LeaderboardState.initial());

  /// Load leaderboard
  Future<void> loadLeaderboard({int page = 1, int limit = 10}) async {
    state = const LeaderboardState.loading();
    
    try {
      final entries = await _service.getLeaderboard(page: page, limit: limit);
      
      state = LeaderboardState.loaded(
        entries,
        currentPage: page,
        hasMore: entries.length >= limit,
      );
    } on ServiceException catch (e) {
      state = LeaderboardState.error(e.message);
    } catch (e) {
      state = LeaderboardState.error('Failed to load leaderboard');
    }
  }

  /// Load more leaderboard entries
  Future<void> loadMore() async {
    state.whenOrNull(
      loaded: (entries, currentPage, hasMore) async {
        if (!hasMore) return;
        
        try {
          final newEntries = await _service.getLeaderboard(page: currentPage + 1);
          
          state = LeaderboardState.loaded(
            [...entries, ...newEntries],
            currentPage: currentPage + 1,
            hasMore: newEntries.isNotEmpty,
          );
        } on ServiceException catch (e) {
          state = LeaderboardState.error(e.message);
        }
      },
    );
  }

  /// Refresh leaderboard
  Future<void> refresh() async {
    await loadLeaderboard();
  }
}

/// Notifier for achievement unlock
class UnlockNotifier extends StateNotifier<UnlockState> {
  final AchievementService _service;
  
  UnlockNotifier(this._service) : super(const UnlockState.idle());

  /// Unlock an achievement
  Future<bool> unlockAchievement(String achievementId, String userId) async {
    state = UnlockState.unlocking(Achievement(id: achievementId));
    
    try {
      final achievement = await _service.unlockAchievement(achievementId, userId);
      state = UnlockState.unlocked(achievement);
      
      // Auto-reset to idle after 3 seconds
      Future.delayed(const Duration(seconds: 3), () {
        if (mounted) {
          state = const UnlockState.idle();
        }
      });
      
      return true;
    } on ServiceException catch (e) {
      state = UnlockState.error(e.message);
      return false;
    } catch (e) {
      state = UnlockState.error('Failed to unlock achievement');
      return false;
    }
  }

  /// Reset state
  void reset() {
    state = const UnlockState.idle();
  }
}

/// Notifier for progress tracking
class ProgressNotifier extends StateNotifier<ProgressState> {
  final AchievementService _service;
  
  ProgressNotifier(this._service) : super(const ProgressState.idle());

  /// Track progress for an achievement
  Future<bool> trackProgress(
    String achievementId,
    String userId,
    int currentProgress,
  ) async {
    state = const ProgressState.updating();
    
    try {
      final result = await _service.trackProgress(achievementId, userId, currentProgress);
      
      final targetProgress = result['targetProgress'] as int? ?? 100;
      final percentage = (currentProgress / targetProgress * 100).clamp(0, 100);
      final completed = currentProgress >= targetProgress;
      
      state = ProgressState.updated(
        currentProgress: currentProgress,
        targetProgress: targetProgress,
        percentage: percentage,
        completed: completed,
      );
      
      return completed;
    } on ServiceException catch (e) {
      state = ProgressState.error(e.message);
      return false;
    } catch (e) {
      state = ProgressState.error('Failed to track progress');
      return false;
    }
  }

  /// Reset state
  void reset() {
    state = const ProgressState.idle();
  }
}
