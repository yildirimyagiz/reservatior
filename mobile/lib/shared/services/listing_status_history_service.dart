import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class ListingStatusHistoryService {
  final DioClient _dioClient;
  ListingStatusHistoryService(this._dioClient);

  Future<ListingStatusHistory> getListingStatusHistoryById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.listingStatusHistories}/$id');
    return ListingStatusHistory.fromJson(response.data['data']);
  }

  Future<List<ListingStatusHistory>> getListingStatusHistories({
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
    final response = await _dioClient.get(ApiEndpoints.listingStatusHistories, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => ListingStatusHistory.fromJson(json)).toList();
  }

  Future<ListingStatusHistory> createListingStatusHistory(ListingStatusHistory item) async {
    final response = await _dioClient.post(ApiEndpoints.listingStatusHistories, data: item.toJson());
    return ListingStatusHistory.fromJson(response.data['data']);
  }

  Future<ListingStatusHistory> updateListingStatusHistory(String id, ListingStatusHistory item) async {
    final response = await _dioClient.patch('${ApiEndpoints.listingStatusHistories}/$id', data: item.toJson());
    return ListingStatusHistory.fromJson(response.data['data']);
  }

  Future<void> deleteListingStatusHistory(String id) async {
    await _dioClient.delete('${ApiEndpoints.listingStatusHistories}/$id');
  }
}
