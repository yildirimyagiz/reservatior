import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class ReviewService {
  final DioClient _dioClient;
  ReviewService(this._dioClient);

  Future<Review> getReviewById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.reviews}/$id');
    return Review.fromJson(response.data['data']);
  }

  Future<List<Review>> getReviews({
    int page = 1, 
    int limit = 20, 
    String? orgId,
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) async {
    final queryParams = {
      'page': page, 
      'limit': limit,
      if (orgId != null) 'orgId': orgId,
      if (sortBy != null) 'sortBy': sortBy,
      if (sortOrder != null) 'sortOrder': sortOrder,
      ...?filters
    };
    final response = await _dioClient.get(ApiEndpoints.reviews, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => Review.fromJson(json)).toList();
  }

  Future<Review> createReview(Review item) async {
    final response = await _dioClient.post(ApiEndpoints.reviews, data: item.toJson());
    return Review.fromJson(response.data['data']);
  }

  Future<Review> updateReview(String id, Review item) async {
    final response = await _dioClient.patch('${ApiEndpoints.reviews}/$id', data: item.toJson());
    return Review.fromJson(response.data['data']);
  }

  Future<void> deleteReview(String id) async {
    await _dioClient.delete('${ApiEndpoints.reviews}/$id');
  }
}
