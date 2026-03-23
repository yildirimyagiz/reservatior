import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class TicketService {
  final DioClient _dioClient;

  TicketService(this._dioClient);

  // Get Ticket by ID
  Future<Ticket> getTicketById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/ticket/$id');
      return Ticket.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all tickets
  Future<List<Ticket>> getTickets({
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

      final response = await _dioClient.get('/api/v1/ticket', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => Ticket.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create Ticket
  Future<Ticket> createTicket(Ticket ticket) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/ticket',
        data: ticket.toJson(),
      );
      return Ticket.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update Ticket
  Future<Ticket> updateTicket(String id, Ticket ticket) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/ticket/$id',
        data: ticket.toJson(),
      );
      return Ticket.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete Ticket
  Future<void> deleteTicket(String id) async {
    try {
      await _dioClient.delete('/api/v1/ticket/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
