import 'package:reservatior/shared/repositories/booking_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetBookingByIdUseCase {
  final BookingRepository _repository;
  GetBookingByIdUseCase(this._repository);
  Future<Booking> execute(String id) => _repository.getById(id);
}

class GetBookingsUseCase {
  final BookingRepository _repository;
  GetBookingsUseCase(this._repository);
  Future<List<Booking>> execute({
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

class CreateBookingUseCase {
  final BookingRepository _repository;
  CreateBookingUseCase(this._repository);
  Future<Booking> execute(Booking item) => _repository.create(item);
}

class UpdateBookingUseCase {
  final BookingRepository _repository;
  UpdateBookingUseCase(this._repository);
  Future<Booking> execute(String id, Booking item) => _repository.update(id, item);
}

class DeleteBookingUseCase {
  final BookingRepository _repository;
  DeleteBookingUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
