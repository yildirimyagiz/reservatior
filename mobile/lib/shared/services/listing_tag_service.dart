import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class ListingTagService {
  final DioClient _dioClient;
  ListingTagService(this._dioClient);

  Future<ListingTag> getListingTagById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.listingTags}/$id');
    return ListingTag.fromJson(response.data['data']);
  }

  Future<List<ListingTag>> getListingTags({
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
    final response = await _dioClient.get(ApiEndpoints.listingTags, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => ListingTag.fromJson(json)).toList();
  }

  Future<ListingTag> createListingTag(ListingTag item) async {
    final response = await _dioClient.post(ApiEndpoints.listingTags, data: item.toJson());
    return ListingTag.fromJson(response.data['data']);
  }

  Future<ListingTag> updateListingTag(String id, ListingTag item) async {
    final response = await _dioClient.patch('${ApiEndpoints.listingTags}/$id', data: item.toJson());
    return ListingTag.fromJson(response.data['data']);
  }

  Future<void> deleteListingTag(String id) async {
    await _dioClient.delete('${ApiEndpoints.listingTags}/$id');
  }
}
