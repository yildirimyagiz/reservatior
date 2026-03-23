import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class ReviewService {
  final DioClient _dioClient;

  ReviewService(this._dioClient);

  // Get Review by ID
  Future<Review> getReviewById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/review/$id');
      return Review.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all reviews
  Future<List<Review>> getReviews({
    int page = 1,
    int limit = 20,
    Map<String, dynamic>? filters,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'page': page.toString(),
        'limit': limit.toString(),
      };

      if (filters != null) {
        queryParams.addAll(filters);
      }

      final response = await _dioClient.get('/api/v1/review', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => Review.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create Review
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
    return Exception('API Error: ${e.message}');
  }
}
