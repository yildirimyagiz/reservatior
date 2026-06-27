import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class ListingChannelService {
  final DioClient _dioClient;
  ListingChannelService(this._dioClient);

  Future<ListingChannel> getListingChannelById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.listingChannels}/$id');
    return ListingChannel.fromJson(response.data['data']);
  }

  Future<List<ListingChannel>> getListingChannels({
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
    final response = await _dioClient.get(ApiEndpoints.listingChannels, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => ListingChannel.fromJson(json)).toList();
  }

  Future<ListingChannel> createListingChannel(ListingChannel item) async {
    final response = await _dioClient.post(ApiEndpoints.listingChannels, data: item.toJson());
    return ListingChannel.fromJson(response.data['data']);
  }

  Future<ListingChannel> updateListingChannel(String id, ListingChannel item) async {
    final response = await _dioClient.patch('${ApiEndpoints.listingChannels}/$id', data: item.toJson());
    return ListingChannel.fromJson(response.data['data']);
  }

  Future<void> deleteListingChannel(String id) async {
    await _dioClient.delete('${ApiEndpoints.listingChannels}/$id');
  }
}
