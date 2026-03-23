import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/repository_exception.dart';

/// Repository for Achievement operations
/// Provides CRUD operations with proper error handling and type safety
class AchievementRepository {
  final DioClient _dioClient;

  AchievementRepository(this._dioClient);

  /// Get Achievement by ID
  Future<Achievement> getAchievementById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/achievements/$id');
      if (response.statusCode == 200) {
        return Achievement.fromJson(response.data['data']);
      } else {
        throw RepositoryException.notFound(
          'Achievement not found',
          code: response.statusCode.toString(),
        );
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
        return data.map((item) => Achievement.fromJson(item)).toList();
      } else {
        throw RepositoryException.fetchError(
          'Failed to fetch achievements',
          code: response.statusCode.toString(),
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get achievements by user ID
  Future<List<Achievement>> getUserAchievements(String userId, {
    bool? completed,
    int page = 1,
    int limit = 20,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'page': page,
        'limit': limit,
        if (completed != null) 'completed': completed,
      };

      final response = await _dioClient.get(
        '/api/v1/achievements/user/$userId',
        queryParameters: queryParams,
      );
      
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => Achievement.fromJson(item)).toList();
      } else {
        throw RepositoryException.fetchError(
          'Failed to fetch user achievements',
          code: response.statusCode.toString(),
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new Achievement
  Future<Achievement> createAchievement(Achievement achievement) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/achievements',
        data: achievement.toJson(),
      );
      if (response.statusCode == 201 || response.statusCode == 200) {
        return Achievement.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to create achievement',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.createError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Update Achievement
  Future<Achievement> updateAchievement(String id, Achievement achievement) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/achievements/$id',
        data: achievement.toJson(),
      );
      if (response.statusCode == 200) {
        return Achievement.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to update achievement',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.updateError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Patch Achievement (partial update)
  Future<Achievement> patchAchievement(String id, Map<String, dynamic> updates) async {
    try {
      final response = await _dioClient.patch(
        '/api/v1/achievements/$id',
        data: updates,
      );
      if (response.statusCode == 200) {
        return Achievement.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to update achievement',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.updateError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Delete Achievement
  Future<void> deleteAchievement(String id) async {
    try {
      final response = await _dioClient.delete('/api/v1/achievements/$id');
      if (response.statusCode != 200 && response.statusCode != 204) {
        throw RepositoryException(
          message: 'Failed to delete achievement',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.deleteError,
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
        throw RepositoryException(
          message: 'Failed to track progress',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.updateError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Unlock achievement
  Future<Achievement> unlockAchievement(String achievementId, String userId) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/achievements/$achievementId/unlock',
        data: {'userId': userId},
      );
      
      if (response.statusCode == 200 || response.statusCode == 201) {
        return Achievement.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to unlock achievement',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.createError,
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
        return data.map((item) => Achievement.fromJson(item)).toList();
      } else {
        throw RepositoryException.fetchError(
          'Search failed',
          code: response.statusCode.toString(),
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get user statistics
  Future<Map<String, dynamic>> getUserStats(String userId) async {
    try {
      final response = await _dioClient.get('/api/v1/achievements/user/$userId/stats');
      
      if (response.statusCode == 200) {
        return response.data['data'] as Map<String, dynamic>;
      } else {
        throw RepositoryException.fetchError(
          'Failed to fetch statistics',
          code: response.statusCode.toString(),
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get global statistics
  Future<Map<String, dynamic>> getGlobalStats() async {
    try {
      final response = await _dioClient.get('/api/v1/achievements/stats');
      
      if (response.statusCode == 200) {
        return response.data['data'] as Map<String, dynamic>;
      } else {
        throw RepositoryException.fetchError(
          'Failed to fetch statistics',
          code: response.statusCode.toString(),
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get leaderboard
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
        throw RepositoryException.fetchError(
          'Failed to fetch leaderboard',
          code: response.statusCode.toString(),
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Handle DioException and convert to RepositoryException
  RepositoryException _handleError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return RepositoryException.network(
          'Connection timeout',
          code: 'TIMEOUT',
          originalError: e,
        );
      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        if (statusCode == 404) {
          return RepositoryException.notFound('Resource not found');
        }
        return RepositoryException(
          message: e.response?.data['message'] ?? 'Server error',
          code: statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
          originalError: e,
        );
      default:
        return RepositoryException.network(
          'Network error: ${e.message}',
          originalError: e,
        );
    }
  }
}
