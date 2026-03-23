import '../../features/shared/services/booking_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for Booking

class GetBookingByIdUseCase {
  final BookingService _service;
  
  GetBookingByIdUseCase(this._service);
  
  Future<Booking> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetBookingsUseCase {
  final BookingService _service;
  
  GetBookingsUseCase(this._service);
  
  Future<List<Booking>> execute({
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

class CreateBookingUseCase {
  final BookingService _service;
  
  CreateBookingUseCase(this._service);
  
  Future<Booking> execute(Booking booking) async {
    // Add validation logic here
    return await _service.create(booking);
  }
}

class UpdateBookingUseCase {
  final BookingService _service;
  
  UpdateBookingUseCase(this._service);
  
  Future<Booking> execute(String id, Booking booking) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, booking);
  }
}

class DeleteBookingUseCase {
  final BookingService _service;
  
  DeleteBookingUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// Booking Use Case Container
class BookingUseCases {
  final GetBookingByIdUseCase getById;
  final GetBookingsUseCase getAll;
  final CreateBookingUseCase create;
  final UpdateBookingUseCase update;
  final DeleteBookingUseCase delete;
  
  BookingUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory BookingUseCases.create(BookingService service) {
    return BookingUseCases(
      getById: GetBookingByIdUseCase(service),
      getAll: GetBookingsUseCase(service),
      create: CreateBookingUseCase(service),
      update: UpdateBookingUseCase(service),
      delete: DeleteBookingUseCase(service),
    );
  }
}
