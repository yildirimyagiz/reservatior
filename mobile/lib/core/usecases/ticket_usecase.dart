import '../../features/shared/services/ticket_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for Ticket

class GetTicketByIdUseCase {
  final TicketService _service;
  
  GetTicketByIdUseCase(this._service);
  
  Future<Ticket> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetTicketsUseCase {
  final TicketService _service;
  
  GetTicketsUseCase(this._service);
  
  Future<List<Ticket>> execute({
    int page = 1,
    int limit = 20,
    Map<String, dynamic>? filters,
  }) async {
    if (page <= 0) {
      throw ArgumentError('Page must be greater than 0');
    }
    if (limit <= 0 || limit > 100) {
      throw ArgumentError('Limit must be between 1 and 100');
    }
    return await _service.getAll(
      page: page,
      limit: limit,
      filters: filters,
    );
  }
}

class CreateTicketUseCase {
  final TicketService _service;
  
  CreateTicketUseCase(this._service);
  
  Future<Ticket> execute(Ticket ticket) async {
    // Add validation logic here
    return await _service.create(ticket);
  }
}

class UpdateTicketUseCase {
  final TicketService _service;
  
  UpdateTicketUseCase(this._service);
  
  Future<Ticket> execute(String id, Ticket ticket) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, ticket);
  }
}

class DeleteTicketUseCase {
  final TicketService _service;
  
  DeleteTicketUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// Ticket Use Case Container
class TicketUseCases {
  final GetTicketByIdUseCase getById;
  final GetTicketsUseCase getAll;
  final CreateTicketUseCase create;
  final UpdateTicketUseCase update;
  final DeleteTicketUseCase delete;
  
  TicketUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory TicketUseCases.create(TicketService service) {
    return TicketUseCases(
      getById: GetTicketByIdUseCase(service),
      getAll: GetTicketsUseCase(service),
      create: CreateTicketUseCase(service),
      update: UpdateTicketUseCase(service),
      delete: DeleteTicketUseCase(service),
    );
  }
}
