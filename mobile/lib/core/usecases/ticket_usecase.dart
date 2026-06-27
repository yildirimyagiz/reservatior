import 'package:reservatior/shared/repositories/ticket_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetTicketByIdUseCase {
  final TicketRepository _repository;
  GetTicketByIdUseCase(this._repository);
  Future<Ticket> execute(String id) => _repository.getById(id);
}

class GetTicketsUseCase {
  final TicketRepository _repository;
  GetTicketsUseCase(this._repository);
  Future<List<Ticket>> execute({
    int page = 1, 
    int limit = 20, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) => _repository.getAll(
    page: page, 
    limit: limit, 
    filters: filters,
    sortBy: sortBy,
    sortOrder: sortOrder,
  );
}

class CreateTicketUseCase {
  final TicketRepository _repository;
  CreateTicketUseCase(this._repository);
  Future<Ticket> execute(Ticket item) => _repository.create(item);
}

class UpdateTicketUseCase {
  final TicketRepository _repository;
  UpdateTicketUseCase(this._repository);
  Future<Ticket> execute(String id, Ticket item) => _repository.update(id, item);
}

class DeleteTicketUseCase {
  final TicketRepository _repository;
  DeleteTicketUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
