import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class GuestReviewService {
  final DioClient _dioClient;
  GuestReviewService(this._dioClient);

  Future<GuestReview> getGuestReviewById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.guestReviews}/$id');
    return GuestReview.fromJson(response.data['data']);
  }

  Future<List<GuestReview>> getGuestReviews({
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
    final response = await _dioClient.get(ApiEndpoints.guestReviews, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => GuestReview.fromJson(json)).toList();
  }

  Future<GuestReview> createGuestReview(GuestReview item) async {
    final response = await _dioClient.post(ApiEndpoints.guestReviews, data: item.toJson());
    return GuestReview.fromJson(response.data['data']);
  }

  Future<GuestReview> updateGuestReview(String id, GuestReview item) async {
    final response = await _dioClient.patch('${ApiEndpoints.guestReviews}/$id', data: item.toJson());
    return GuestReview.fromJson(response.data['data']);
  }

  Future<void> deleteGuestReview(String id) async {
    await _dioClient.delete('${ApiEndpoints.guestReviews}/$id');
  }
}
