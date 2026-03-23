import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/repository_exception.dart';

/// Repository for Ticket operations
/// Provides CRUD operations with proper error handling and type safety
class TicketRepository {
  final DioClient _dioClient;

  TicketRepository(this._dioClient);

  /// Get Ticket by ID
  /// Returns [Ticket] if found, throws [RepositoryException] otherwise
  Future<Ticket> getTicketById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/ticket/$id');
      if (response.statusCode == 200) {
        return Ticket.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to fetch ticket',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.notFound,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all tickets with pagination and filtering
  /// Returns list of [Ticket] objects
  Future<List<Ticket>> gettickets({
    int page = 1,
    int limit = 20,
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'page': page,
        'limit': limit,
        if (sortBy != null) 'sort_by': sortBy,
        if (sortOrder != null) 'sort_order': sortOrder,
        ...?filters,
      };
      
      final response = await _dioClient.get('/api/v1/ticket', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => Ticket.fromJson(item)).toList();
      } else {
        throw RepositoryException(
          message: 'Failed to fetch tickets',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new Ticket
  /// Returns created [Ticket] object
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
    // Implement error handling logic here
    return Exception('API Error: ${e.message}');
  }
}
