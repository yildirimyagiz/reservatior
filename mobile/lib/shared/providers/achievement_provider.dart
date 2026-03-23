import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/achievement_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../features/achievement/domain/achievement_state.dart';
import '../../features/achievement/domain/achievement_notifier.dart';
import 'dio_client_provider.dart';

// ─── Core Providers ─────────────────────────────────────────────────

/// DioClient provider - singleton instance

/// AchievementService provider
final achievementServiceProvider = Provider<AchievementService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return AchievementService(dioClient);
});

// ─── State Notifier Providers ───────────────────────────────────────

/// Achievement list state notifier provider
final achievementListProvider = StateNotifierProvider<AchievementListNotifier, AchievementListState>((ref) {
  final service = ref.watch(achievementServiceProvider);
  return AchievementListNotifier(service);
});

/// Single achievement state notifier provider
final achievementListProvider = StateNotifierProvider<AchievementNotifier, AchievementState>((ref) {
  final service = ref.watch(achievementServiceProvider);
  return AchievementNotifier(service);
});

/// Achievement stats state notifier provider
final achievementStatsProvider = StateNotifierProvider<AchievementStatsNotifier, AchievementStatsState>((ref) {
  final service = ref.watch(achievementServiceProvider);
  return AchievementStatsNotifier(service);
});

/// Leaderboard state notifier provider
final leaderboardProvider = StateNotifierProvider<LeaderboardNotifier, LeaderboardState>((ref) {
  final service = ref.watch(achievementServiceProvider);
  return LeaderboardNotifier(service);
});

/// Unlock state notifier provider
final unlockProvider = StateNotifierProvider<UnlockNotifier, UnlockState>((ref) {
  final service = ref.watch(achievementServiceProvider);
  return UnlockNotifier(service);
});

/// Progress state notifier provider
final progressProvider = StateNotifierProvider<ProgressNotifier, ProgressState>((ref) {
  final service = ref.watch(achievementServiceProvider);
  return ProgressNotifier(service);
});

// ─── Specific Data Providers ────────────────────────────────────────

/// Get achievement by ID
final achievementByIdProvider = FutureProvider.family<Achievement, String>((ref, id) async {
  final service = ref.watch(achievementServiceProvider);
  return service.getAchievementById(id);
});

/// Get user achievements
final userAchievementsProvider = FutureProvider.family<List<Achievement>, String>((ref, userId) async {
  final service = ref.watch(achievementServiceProvider);
  return service.getUserAchievements(userId);
});

/// Get unlocked achievements for user
final unlockedAchievementsProvider = FutureProvider.family<List<Achievement>, String>((ref, userId) async {
  final service = ref.watch(achievementServiceProvider);
  return service.getUnlockedAchievements(userId);
});

/// Get locked achievements for user
final lockedAchievementsProvider = FutureProvider.family<List<Achievement>, String>((ref, userId) async {
  final service = ref.watch(achievementServiceProvider);
  return service.getLockedAchievements(userId);
});

/// Search achievements provider
final achievementSearchProvider = FutureProvider.family<List<Achievement>, String>((ref, query) async {
  final service = ref.watch(achievementServiceProvider);
  return service.searchAchievements(query: query);
});

/// Get user stats
final userStatsProvider = FutureProvider.family<Map<String, dynamic>, String>((ref, userId) async {
  final service = ref.watch(achievementServiceProvider);
  return service.getUserStats(userId);
});

/// Get global stats
final globalStatsProvider = FutureProvider<Map<String, dynamic>>((ref) async {
  final service = ref.watch(achievementServiceProvider);
  return service.getGlobalStats();
});

// ─── Action Providers ───────────────────────────────────────────────

/// Provider for creating an achievement
final createAchievementProvider = Provider<Future<Achievement> Function(Achievement)>((ref) {
  final service = ref.watch(achievementServiceProvider);
  return (achievement) => service.createAchievement(achievement);
});

/// Provider for updating an achievement
final updateAchievementProvider = Provider<Future<Achievement> Function(String, Achievement)>((ref) {
  final service = ref.watch(achievementServiceProvider);
  return (id, achievement) => service.updateAchievement(id, achievement);
});

/// Provider for deleting an achievement
final deleteAchievementProvider = Provider<Future<void> Function(String)>((ref) {
  final service = ref.watch(achievementServiceProvider);
  return (id) => service.deleteAchievement(id);
});

/// Provider for unlocking an achievement
final unlockAchievementProvider = Provider<Future<Achievement> Function(String, String)>((ref) {
  final service = ref.watch(achievementServiceProvider);
  return (achievementId, userId) => service.unlockAchievement(achievementId, userId);
});

/// Provider for tracking progress
final trackProgressProvider = Provider<Future<Map<String, dynamic>> Function(String, String, int)>((ref) {
  final service = ref.watch(achievementServiceProvider);
  return (achievementId, userId, progress) => service.trackProgress(achievementId, userId, progress);
});

// ─── Utility Providers ──────────────────────────────────────────────

/// Loading state provider - checks if any operation is in progress
final achievementLoadingProvider = Provider<bool>((ref) {
  final listState = ref.watch(achievementListProvider);
  final achievementState = ref.watch(achievementListProvider);
  final statsState = ref.watch(achievementStatsProvider);
  final leaderboardState = ref.watch(leaderboardProvider);
  final unlockState = ref.watch(unlockProvider);
  final progressState = ref.watch(progressProvider);
  
  return listState is _Loading || 
         achievementState is _AchievementLoading ||
         statsState is _StatsLoading ||
         leaderboardState is _LeaderboardLoading ||
         unlockState is _Unlocking ||
         progressState is _ProgressUpdating;
});

/// Error message provider - returns current error if any
final achievementErrorProvider = Provider<String?>((ref) {
  final listState = ref.watch(achievementListProvider);
  final achievementState = ref.watch(achievementListProvider);
  final statsState = ref.watch(achievementStatsProvider);
  
  return listState.maybeWhen(
    error: (message) => message,
    orElse: () => achievementState.maybeWhen(
      error: (message) => message,
      orElse: () => statsState.maybeWhen(
        error: (message) => message,
        orElse: () => null,
      ),
    ),
  );
});

/// Current achievements list provider - extracts achievements from list state
final currentAchievementsProvider = Provider<List<Achievement>>((ref) {
  final state = ref.watch(achievementListProvider);
  return state.maybeWhen(
    loaded: (achievements, _, __, ___) => achievements,
    orElse: () => [],
  );
});

/// Current achievement provider - extracts achievement from achievement state
final currentAchievementProvider = Provider<Achievement?>((ref) {
  final state = ref.watch(achievementListProvider);
  return state.maybeWhen(
    loaded: (achievement) => achievement,
    orElse: () => null,
  );
});

/// Achievement stats data provider - extracts stats from stats state
final achievementStatsDataProvider = Provider<Map<String, dynamic>?>((ref) {
  final state = ref.watch(achievementStatsProvider);
  return state.maybeWhen(
    loaded: (stats) => stats,
    orElse: () => null,
  );
});

/// Leaderboard entries provider - extracts entries from leaderboard state
final leaderboardEntriesProvider = Provider<List<Map<String, dynamic>>>((ref) {
  final state = ref.watch(leaderboardProvider);
  return state.maybeWhen(
    loaded: (entries, _, __) => entries,
    orElse: () => [],
  );
});

/// Recently unlocked achievement provider
final recentlyUnlockedProvider = Provider<Achievement?>((ref) {
  final state = ref.watch(unlockProvider);
  return state.maybeWhen(
    unlocked: (achievement) => achievement,
    orElse: () => null,
  );
});

/// Progress percentage provider
final progressPercentageProvider = Provider<double?>((ref) {
  final state = ref.watch(progressProvider);
  return state.maybeWhen(
    updated: (_, __, percentage, ___) => percentage,
    orElse: () => null,
  );
});

// ─── Helper Providers for UI ────────────────────────────────────────

/// Get completion percentage for an achievement
final achievementCompletionProvider = Provider.family<double, Achievement>((ref, achievement) {
  if (achievement.goalValue == null || achievement.goalValue == 0) return 0.0;
  final current = achievement.currentValue ?? 0;
  final target = achievement.goalValue!;
  return (current / target * 100).clamp(0, 100);
});

/// Check if achievement is completed
final isAchievementCompletedProvider = Provider.family<bool, Achievement>((ref, achievement) {
  return achievement.isCompleted ?? false;
});

/// Get achievement goal type display name
final goalTypeDisplayProvider = Provider.family<String, GoalType?>((ref, goalType) {
  if (goalType == null) return 'Unknown';
  // You can customize this based on your GoalType enum
  return goalType.toString().split('.').last;
});

// ─── Legacy Compatibility (deprecated) ──────────────────────────────

@Deprecated('Use achievementServiceProvider instead')
final achievementServiceProvider = achievementServiceProvider;

@Deprecated('Use achievementListProvider instead')
final achievementListStateProvider = achievementListProvider;

@Deprecated('Use createAchievementProvider instead')
final achievementCreateProvider = createAchievementProvider;

@Deprecated('Use updateAchievementProvider instead')
final achievementUpdateProvider = updateAchievementProvider;

@Deprecated('Use deleteAchievementProvider instead')
final achievementDeleteProvider = deleteAchievementProvider;

@Deprecated('Use achievementLoadingProvider instead')
final achievementLoadingProvider = achievementLoadingProvider;
