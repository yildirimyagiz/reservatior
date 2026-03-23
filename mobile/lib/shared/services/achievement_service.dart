import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/service_exception.dart';

/// Service for Achievement operations with gamification features
/// Provides CRUD operations, unlocking logic, and progress tracking
class AchievementService {
  final DioClient _dioClient;

  AchievementService(this._dioClient);

  /// Get Achievement by ID
  Future<Achievement> getAchievementById(String id) async {
    if (id.isEmpty) {
      throw ServiceException.validation('Achievement ID cannot be empty');
    }

    try {
      final response = await _dioClient.get('/api/v1/achievements/$id');
      if (response.statusCode == 200) {
        return Achievement.fromJson(response.data['data']);
      } else {
        throw ServiceException.notFound('Achievement not found');
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all achievements with pagination and filtering
  Future<List<Achievement>> getAchievements({
    int page = 1,
    int limit = 20,
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) async {
    if (page <= 0) {
      throw ServiceException.validation('Page must be greater than 0');
    }

    if (limit <= 0 || limit > 100) {
      throw ServiceException.validation('Limit must be between 1 and 100');
    }

    try {
      final queryParams = <String, dynamic>{
        'page': page,
        'limit': limit,
        if (sortBy != null) 'sort_by': sortBy,
        if (sortOrder != null) 'sort_order': sortOrder,
        ...?filters,
      };

      final response = await _dioClient.get('/api/v1/achievements', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((json) => Achievement.fromJson(json)).toList();
      } else {
        throw ServiceException(
          message: 'Failed to fetch achievements',
          code: response.statusCode.toString(),
          type: ServiceExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get achievements by user ID
  Future<List<Achievement>> getUserAchievements(String userId, {
    bool? unlocked,
    int page = 1,
    int limit = 20,
  }) async {
    if (userId.isEmpty) {
      throw ServiceException.validation('User ID cannot be empty');
    }

    try {
      final queryParams = <String, dynamic>{
        'page': page,
        'limit': limit,
        if (unlocked != null) 'unlocked': unlocked,
      };

      final response = await _dioClient.get(
        '/api/v1/achievements/user/$userId',
        queryParameters: queryParams,
      );
      
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((json) => Achievement.fromJson(json)).toList();
      } else {
        throw ServiceException(
          message: 'Failed to fetch user achievements',
          code: response.statusCode.toString(),
          type: ServiceExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get unlocked achievements for a user
  Future<List<Achievement>> getUnlockedAchievements(String userId) async {
    return getUserAchievements(userId, unlocked: true);
  }

  /// Get locked (not yet unlocked) achievements for a user
  Future<List<Achievement>> getLockedAchievements(String userId) async {
    return getUserAchievements(userId, unlocked: false);
  }

  /// Unlock an achievement for a user
  Future<Achievement> unlockAchievement(String achievementId, String userId) async {
    if (achievementId.isEmpty || userId.isEmpty) {
      throw ServiceException.validation('Achievement ID and User ID are required');
    }

    try {
      final response = await _dioClient.post(
        '/api/v1/achievements/$achievementId/unlock',
        data: {'userId': userId},
      );
      
      if (response.statusCode == 200 || response.statusCode == 201) {
        return Achievement.fromJson(response.data['data']);
      } else {
        throw ServiceException(
          message: 'Failed to unlock achievement',
          code: response.statusCode.toString(),
          type: ServiceExceptionType.createError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Track progress for an achievement
  Future<Map<String, dynamic>> trackProgress(
    String achievementId,
    String userId,
    int currentProgress,
  ) async {
    if (achievementId.isEmpty || userId.isEmpty) {
      throw ServiceException.validation('Achievement ID and User ID are required');
    }

    if (currentProgress < 0) {
      throw ServiceException.validation('Progress cannot be negative');
    }

    try {
      final response = await _dioClient.post(
        '/api/v1/achievements/$achievementId/progress',
        data: {
          'userId': userId,
          'progress': currentProgress,
        },
      );
      
      if (response.statusCode == 200) {
        return response.data['data'] as Map<String, dynamic>;
      } else {
        throw ServiceException(
          message: 'Failed to track progress',
          code: response.statusCode.toString(),
          type: ServiceExceptionType.updateError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get achievement statistics for a user
  Future<Map<String, dynamic>> getUserStats(String userId) async {
    if (userId.isEmpty) {
      throw ServiceException.validation('User ID cannot be empty');
    }

    try {
      final response = await _dioClient.get('/api/v1/achievements/user/$userId/stats');
      
      if (response.statusCode == 200) {
        return response.data['data'] as Map<String, dynamic>;
      } else {
        throw ServiceException(
          message: 'Failed to fetch user statistics',
          code: response.statusCode.toString(),
          type: ServiceExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get global achievement statistics
  Future<Map<String, dynamic>> getGlobalStats() async {
    try {
      final response = await _dioClient.get('/api/v1/achievements/stats');
      
      if (response.statusCode == 200) {
        return response.data['data'] as Map<String, dynamic>;
      } else {
        throw ServiceException(
          message: 'Failed to fetch statistics',
          code: response.statusCode.toString(),
          type: ServiceExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get leaderboard for achievements
  Future<List<Map<String, dynamic>>> getLeaderboard({
    int page = 1,
    int limit = 10,
  }) async {
    try {
      final response = await _dioClient.get(
        '/api/v1/achievements/leaderboard',
        queryParameters: {
          'page': page,
          'limit': limit,
        },
      );
      
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => item as Map<String, dynamic>).toList();
      } else {
        throw ServiceException(
          message: 'Failed to fetch leaderboard',
          code: response.statusCode.toString(),
          type: ServiceExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Search achievements
  Future<List<Achievement>> searchAchievements({
    required String query,
    int page = 1,
    int limit = 20,
  }) async {
    if (query.isEmpty) {
      throw ServiceException.validation('Search query cannot be empty');
    }

    try {
      final response = await _dioClient.get(
        '/api/v1/achievements/search',
        queryParameters: {
          'q': query,
          'page': page,
          'limit': limit,
        },
      );
      
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((json) => Achievement.fromJson(json)).toList();
      } else {
        throw ServiceException(
          message: 'Search failed',
          code: response.statusCode.toString(),
          type: ServiceExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create Achievement
  Future<Achievement> createAchievement(Achievement achievement) async {
    _validateAchievement(achievement);

    try {
      final response = await _dioClient.post(
        '/api/v1/achievements',
        data: achievement.toJson(),
      );
      
      if (response.statusCode == 201 || response.statusCode == 200) {
        return Achievement.fromJson(response.data['data']);
      } else {
        throw ServiceException(
          message: 'Failed to create achievement',
          code: response.statusCode.toString(),
          type: ServiceExceptionType.createError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Update Achievement
  Future<Achievement> updateAchievement(String id, Achievement achievement) async {
    if (id.isEmpty) {
      throw ServiceException.validation('Achievement ID cannot be empty');
    }

    _validateAchievement(achievement);

    try {
      final response = await _dioClient.put(
        '/api/v1/achievements/$id',
        data: achievement.toJson(),
      );
      
      if (response.statusCode == 200) {
        return Achievement.fromJson(response.data['data']);
      } else {
        throw ServiceException(
          message: 'Failed to update achievement',
          code: response.statusCode.toString(),
          type: ServiceExceptionType.updateError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Delete Achievement
  Future<void> deleteAchievement(String id) async {
    if (id.isEmpty) {
      throw ServiceException.validation('Achievement ID cannot be empty');
    }

    try {
      final response = await _dioClient.delete('/api/v1/achievements/$id');
      if (response.statusCode != 200 && response.statusCode != 204) {
        throw ServiceException(
          message: 'Failed to delete achievement',
          code: response.statusCode.toString(),
          type: ServiceExceptionType.deleteError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Validate achievement data
  void _validateAchievement(Achievement achievement) {
    if (achievement.userId == null || achievement.userId!.isEmpty) {
      throw ServiceException.validation('User ID is required');
    }

    if (achievement.goalType == null) {
      throw ServiceException.validation('Goal type is required');
    }

    if (achievement.goalValue != null && achievement.goalValue! < 0) {
      throw ServiceException.validation('Goal value cannot be negative');
    }

    if (achievement.currentValue != null && achievement.currentValue! < 0) {
      throw ServiceException.validation('Current value cannot be negative');
    }

    if (achievement.pointsReward != null && achievement.pointsReward! < 0) {
      throw ServiceException.validation('Points reward cannot be negative');
    }
  }

  /// Handle DioException and convert to ServiceException
  ServiceException _handleError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return ServiceException.network(
          'Connection timeout',
          code: 'TIMEOUT',
          originalError: e,
        );
      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        if (statusCode == 404) {
          return ServiceException.notFound('Resource not found');
        } else if (statusCode == 401) {
          return ServiceException.unauthorized('Unauthorized');
        }
        return ServiceException(
          message: e.response?.data['message'] ?? 'Server error',
          code: statusCode.toString(),
          type: ServiceExceptionType.fetchError,
          originalError: e,
        );
      case DioExceptionType.cancel:
        return ServiceException(
          message: 'Request cancelled',
          code: 'CANCELLED',
          type: ServiceExceptionType.unknown,
          originalError: e,
        );
      default:
        return ServiceException.network(
          'Network error: ${e.message}',
          originalError: e,
        );
    }
  }
}
