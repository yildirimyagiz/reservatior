import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class MessageService {
  final DioClient _dioClient;
  MessageService(this._dioClient);

  Future<Message> getMessageById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.messages}/$id');
    return Message.fromJson(response.data['data']);
  }

  Future<List<Message>> getMessages({
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
    final response = await _dioClient.get(ApiEndpoints.messages, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => Message.fromJson(json)).toList();
  }

  Future<Message> createMessage(Message item) async {
    final response = await _dioClient.post(ApiEndpoints.messages, data: item.toJson());
    return Message.fromJson(response.data['data']);
  }

  Future<Message> updateMessage(String id, Message item) async {
    final response = await _dioClient.patch('${ApiEndpoints.messages}/$id', data: item.toJson());
    return Message.fromJson(response.data['data']);
  }

  Future<void> deleteMessage(String id) async {
    await _dioClient.delete('${ApiEndpoints.messages}/$id');
  }
  Future<List<Message>> getThreads({
    int page = 1, 
    int limit = 20, 
    String? orgId,
  }) async {
    final queryParams = {
      'page': page, 
      'limit': limit,
      if (orgId != null) 'orgId': orgId,
    };
    final response = await _dioClient.get(ApiEndpoints.threads, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => Message.fromJson(json)).toList();
  }

  Future<List<Message>> getThreadMessages(String threadId) async {
    final response = await _dioClient.get('${ApiEndpoints.threads}/$threadId');
    final data = response.data['data'] as List;
    return data.map((json) => Message.fromJson(json)).toList();
  }

  Future<Message> replyToThread(String threadId, Message item) async {
    final response = await _dioClient.post('${ApiEndpoints.threads}/$threadId', data: item.toJson());
    return Message.fromJson(response.data['data']);
  }
}
