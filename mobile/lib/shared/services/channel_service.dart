import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class ChannelService {
  final DioClient _dioClient;

  ChannelService(this._dioClient);

  // Get Channel by ID
  Future<Channel> getChannelById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/channel/$id');
      return Channel.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all channels
  Future<List<Channel>> getChannels({
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

      final response = await _dioClient.get('/api/v1/channel', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => Channel.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create Channel
  Future<Channel> createChannel(Channel channel) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/channel',
        data: channel.toJson(),
      );
      return Channel.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update Channel
  Future<Channel> updateChannel(String id, Channel channel) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/channel/$id',
        data: channel.toJson(),
      );
      return Channel.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete Channel
  Future<void> deleteChannel(String id) async {
    try {
      await _dioClient.delete('/api/v1/channel/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
