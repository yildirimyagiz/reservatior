import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class GuestReviewService {
  final DioClient _dioClient;

  GuestReviewService(this._dioClient);

  // Get GuestReview by ID
  Future<GuestReview> getGuestReviewById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/guest_review/$id');
      return GuestReview.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all guest_reviews
  Future<List<GuestReview>> getGuestReviews({
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

      final response = await _dioClient.get('/api/v1/guest_review', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => GuestReview.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create GuestReview
  Future<GuestReview> createGuestReview(GuestReview guestReview) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/guest_review',
        data: guestReview.toJson(),
      );
      return GuestReview.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update GuestReview
  Future<GuestReview> updateGuestReview(String id, GuestReview guestReview) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/guest_review/$id',
        data: guestReview.toJson(),
      );
      return GuestReview.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete GuestReview
  Future<void> deleteGuestReview(String id) async {
    try {
      await _dioClient.delete('/api/v1/guest_review/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
