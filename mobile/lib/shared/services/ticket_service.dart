import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class TicketService {
  final DioClient _dioClient;
  TicketService(this._dioClient);

  Future<Ticket> getTicketById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.tickets}/$id');
    return Ticket.fromJson(response.data['data']);
  }

  Future<List<Ticket>> getTickets({
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
    final response = await _dioClient.get(ApiEndpoints.tickets, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => Ticket.fromJson(json)).toList();
  }

  Future<Ticket> createTicket(Ticket item) async {
    final response = await _dioClient.post(ApiEndpoints.tickets, data: item.toJson());
    return Ticket.fromJson(response.data['data']);
  }

  Future<Ticket> updateTicket(String id, Ticket item) async {
    final response = await _dioClient.patch('${ApiEndpoints.tickets}/$id', data: item.toJson());
    return Ticket.fromJson(response.data['data']);
  }

  Future<void> deleteTicket(String id) async {
    await _dioClient.delete('${ApiEndpoints.tickets}/$id');
  }
}
