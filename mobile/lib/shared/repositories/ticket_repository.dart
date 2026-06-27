import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/ticket_service.dart';

abstract class TicketRepository {
  Future<Ticket> getById(String id);
  Future<List<Ticket>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<Ticket> create(Ticket item);
  Future<Ticket> update(String id, Ticket item);
  Future<void> delete(String id);
}

class TicketRepositoryImpl implements TicketRepository {
  final TicketService _service;
  TicketRepositoryImpl(this._service);

  @override
  Future<Ticket> getById(String id) => _service.getTicketById(id);

  @override
  Future<List<Ticket>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getTickets(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<Ticket> create(Ticket item) => _service.createTicket(item);

  @override
  Future<Ticket> update(String id, Ticket item) => _service.updateTicket(id, item);

  @override
  Future<void> delete(String id) => _service.deleteTicket(id);
}
