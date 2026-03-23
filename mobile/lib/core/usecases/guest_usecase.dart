import '../../features/shared/services/guest_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for Guest

class GetGuestByIdUseCase {
  final GuestService _service;
  
  GetGuestByIdUseCase(this._service);
  
  Future<Guest> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetGuestsUseCase {
  final GuestService _service;
  
  GetGuestsUseCase(this._service);
  
  Future<List<Guest>> execute({
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

class CreateGuestUseCase {
  final GuestService _service;
  
  CreateGuestUseCase(this._service);
  
  Future<Guest> execute(Guest guest) async {
    // Add validation logic here
    return await _service.create(guest);
  }
}

class UpdateGuestUseCase {
  final GuestService _service;
  
  UpdateGuestUseCase(this._service);
  
  Future<Guest> execute(String id, Guest guest) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, guest);
  }
}

class DeleteGuestUseCase {
  final GuestService _service;
  
  DeleteGuestUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// Guest Use Case Container
class GuestUseCases {
  final GetGuestByIdUseCase getById;
  final GetGuestsUseCase getAll;
  final CreateGuestUseCase create;
  final UpdateGuestUseCase update;
  final DeleteGuestUseCase delete;
  
  GuestUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory GuestUseCases.create(GuestService service) {
    return GuestUseCases(
      getById: GetGuestByIdUseCase(service),
      getAll: GetGuestsUseCase(service),
      create: CreateGuestUseCase(service),
      update: UpdateGuestUseCase(service),
      delete: DeleteGuestUseCase(service),
    );
  }
}
