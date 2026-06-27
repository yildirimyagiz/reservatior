import 'package:reservatior/shared/repositories/reservation_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetReservationByIdUseCase {
  final ReservationRepository _repository;
  GetReservationByIdUseCase(this._repository);
  Future<Reservation> execute(String id) => _repository.getById(id);
}

class GetReservationsUseCase {
  final ReservationRepository _repository;
  GetReservationsUseCase(this._repository);
  Future<List<Reservation>> execute({
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

class CreateReservationUseCase {
  final ReservationRepository _repository;
  CreateReservationUseCase(this._repository);
  Future<Reservation> execute(Reservation item) => _repository.create(item);
}

class UpdateReservationUseCase {
  final ReservationRepository _repository;
  UpdateReservationUseCase(this._repository);
  Future<Reservation> execute(String id, Reservation item) => _repository.update(id, item);
}

class DeleteReservationUseCase {
  final ReservationRepository _repository;
  DeleteReservationUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
