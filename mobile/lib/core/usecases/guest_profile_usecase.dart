import '../../features/shared/services/guest_profile_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for GuestProfile

class GetGuestProfileByIdUseCase {
  final GuestProfileService _service;
  
  GetGuestProfileByIdUseCase(this._service);
  
  Future<GuestProfile> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetGuestProfilesUseCase {
  final GuestProfileService _service;
  
  GetGuestProfilesUseCase(this._service);
  
  Future<List<GuestProfile>> execute({
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

class CreateGuestProfileUseCase {
  final GuestProfileService _service;
  
  CreateGuestProfileUseCase(this._service);
  
  Future<GuestProfile> execute(GuestProfile guestProfile) async {
    // Add validation logic here
    return await _service.create(guestProfile);
  }
}

class UpdateGuestProfileUseCase {
  final GuestProfileService _service;
  
  UpdateGuestProfileUseCase(this._service);
  
  Future<GuestProfile> execute(String id, GuestProfile guestProfile) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, guestProfile);
  }
}

class DeleteGuestProfileUseCase {
  final GuestProfileService _service;
  
  DeleteGuestProfileUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// GuestProfile Use Case Container
class GuestProfileUseCases {
  final GetGuestProfileByIdUseCase getById;
  final GetGuestProfilesUseCase getAll;
  final CreateGuestProfileUseCase create;
  final UpdateGuestProfileUseCase update;
  final DeleteGuestProfileUseCase delete;
  
  GuestProfileUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory GuestProfileUseCases.create(GuestProfileService service) {
    return GuestProfileUseCases(
      getById: GetGuestProfileByIdUseCase(service),
      getAll: GetGuestProfilesUseCase(service),
      create: CreateGuestProfileUseCase(service),
      update: UpdateGuestProfileUseCase(service),
      delete: DeleteGuestProfileUseCase(service),
    );
  }
}
