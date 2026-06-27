import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class ChannelService {
  final DioClient _dioClient;
  ChannelService(this._dioClient);

  Future<Channel> getChannelById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.channels}/$id');
    return Channel.fromJson(response.data['data']);
  }

  Future<List<Channel>> getChannels({
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
    final response = await _dioClient.get(ApiEndpoints.channels, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => Channel.fromJson(json)).toList();
  }

  Future<Channel> createChannel(Channel item) async {
    final response = await _dioClient.post(ApiEndpoints.channels, data: item.toJson());
    return Channel.fromJson(response.data['data']);
  }

  Future<Channel> updateChannel(String id, Channel item) async {
    final response = await _dioClient.patch('${ApiEndpoints.channels}/$id', data: item.toJson());
    return Channel.fromJson(response.data['data']);
  }

  Future<void> deleteChannel(String id) async {
    await _dioClient.delete('${ApiEndpoints.channels}/$id');
  }
}
