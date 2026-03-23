import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../gen_models/models_library.dart';

part 'achievement_state.freezed.dart';

/// State for achievement list
@freezed
class AchievementListState with _$AchievementListState {
  const factory AchievementListState.initial() = _Initial;
  const factory AchievementListState.loading() = _Loading;
  const factory AchievementListState.loaded(
    List<Achievement> achievements, {
    @Default(1) int currentPage,
    @Default(false) bool hasMore,
    @Default(0) int total,
  }) = _Loaded;
  const factory AchievementListState.error(String message) = _Error;
}

/// State for single achievement
@freezed
class AchievementState with _$AchievementState {
  const factory AchievementState.initial() = _AchievementInitial;
  const factory AchievementState.loading() = _AchievementLoading;
  const factory AchievementState.loaded(Achievement achievement) = _AchievementLoaded;
  const factory AchievementState.error(String message) = _AchievementError;
}

/// State for achievement statistics
@freezed
class AchievementStatsState with _$AchievementStatsState {
  const factory AchievementStatsState.initial() = _StatsInitial;
  const factory AchievementStatsState.loading() = _StatsLoading;
  const factory AchievementStatsState.loaded(Map<String, dynamic> stats) = _StatsLoaded;
  const factory AchievementStatsState.error(String message) = _StatsError;
}

/// State for leaderboard
@freezed
class LeaderboardState with _$LeaderboardState {
  const factory LeaderboardState.initial() = _LeaderboardInitial;
  const factory LeaderboardState.loading() = _LeaderboardLoading;
  const factory LeaderboardState.loaded(
    List<Map<String, dynamic>> entries, {
    @Default(1) int currentPage,
    @Default(false) bool hasMore,
  }) = _LeaderboardLoaded;
  const factory LeaderboardState.error(String message) = _LeaderboardError;
}

/// State for achievement unlock animation
@freezed
class UnlockState with _$UnlockState {
  const factory UnlockState.idle() = _UnlockIdle;
  const factory UnlockState.unlocking(Achievement achievement) = _Unlocking;
  const factory UnlockState.unlocked(Achievement achievement) = _Unlocked;
  const factory UnlockState.error(String message) = _UnlockError;
}

/// State for progress tracking
@freezed
class ProgressState with _$ProgressState {
  const factory ProgressState.idle() = _ProgressIdle;
  const factory ProgressState.updating() = _ProgressUpdating;
  const factory ProgressState.updated({
    required int currentProgress,
    required int targetProgress,
    required double percentage,
    required bool completed,
  }) = _ProgressUpdated;
  const factory ProgressState.error(String message) = _ProgressError;
}
