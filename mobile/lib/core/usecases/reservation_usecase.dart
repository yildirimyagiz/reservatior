import '../../features/shared/services/reservation_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for Reservation

class GetReservationByIdUseCase {
  final ReservationService _service;
  
  GetReservationByIdUseCase(this._service);
  
  Future<Reservation> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetReservationsUseCase {
  final ReservationService _service;
  
  GetReservationsUseCase(this._service);
  
  Future<List<Reservation>> execute({
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

class CreateReservationUseCase {
  final ReservationService _service;
  
  CreateReservationUseCase(this._service);
  
  Future<Reservation> execute(Reservation reservation) async {
    // Add validation logic here
    return await _service.create(reservation);
  }
}

class UpdateReservationUseCase {
  final ReservationService _service;
  
  UpdateReservationUseCase(this._service);
  
  Future<Reservation> execute(String id, Reservation reservation) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, reservation);
  }
}

class DeleteReservationUseCase {
  final ReservationService _service;
  
  DeleteReservationUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// Reservation Use Case Container
class ReservationUseCases {
  final GetReservationByIdUseCase getById;
  final GetReservationsUseCase getAll;
  final CreateReservationUseCase create;
  final UpdateReservationUseCase update;
  final DeleteReservationUseCase delete;
  
  ReservationUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory ReservationUseCases.create(ReservationService service) {
    return ReservationUseCases(
      getById: GetReservationByIdUseCase(service),
      getAll: GetReservationsUseCase(service),
      create: CreateReservationUseCase(service),
      update: UpdateReservationUseCase(service),
      delete: DeleteReservationUseCase(service),
    );
  }
}
