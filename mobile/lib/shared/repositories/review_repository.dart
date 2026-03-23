import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/repository_exception.dart';

/// Repository for Review operations
/// Provides CRUD operations with proper error handling and type safety
class ReviewRepository {
  final DioClient _dioClient;

  ReviewRepository(this._dioClient);

  /// Get Review by ID
  /// Returns [Review] if found, throws [RepositoryException] otherwise
  Future<Review> getReviewById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/review/$id');
      if (response.statusCode == 200) {
        return Review.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to fetch review',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.notFound,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all reviews with pagination and filtering
  /// Returns list of [Review] objects
  Future<List<Review>> getreviews({
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
      
      final response = await _dioClient.get('/api/v1/review', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => Review.fromJson(item)).toList();
      } else {
        throw RepositoryException(
          message: 'Failed to fetch reviews',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new Review
  /// Returns created [Review] object
  Future<Review> createReview(Review review) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/review',
        data: review.toJson(),
      );
      return Review.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update Review
  Future<Review> updateReview(String id, Review review) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/review/$id',
        data: review.toJson(),
      );
      return Review.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete Review
  Future<void> deleteReview(String id) async {
    try {
      await _dioClient.delete('/api/v1/review/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    // Implement error handling logic here
    return Exception('API Error: ${e.message}');
  }
}
