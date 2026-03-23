import '../../features/shared/services/vacation_rental_platform_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for VacationRentalPlatform

class GetVacationRentalPlatformByIdUseCase {
  final VacationRentalPlatformService _service;
  
  GetVacationRentalPlatformByIdUseCase(this._service);
  
  Future<VacationRentalPlatform> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetVacationRentalPlatformsUseCase {
  final VacationRentalPlatformService _service;
  
  GetVacationRentalPlatformsUseCase(this._service);
  
  Future<List<VacationRentalPlatform>> execute({
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

class CreateVacationRentalPlatformUseCase {
  final VacationRentalPlatformService _service;
  
  CreateVacationRentalPlatformUseCase(this._service);
  
  Future<VacationRentalPlatform> execute(VacationRentalPlatform vacationRentalPlatform) async {
    // Add validation logic here
    return await _service.create(vacationRentalPlatform);
  }
}

class UpdateVacationRentalPlatformUseCase {
  final VacationRentalPlatformService _service;
  
  UpdateVacationRentalPlatformUseCase(this._service);
  
  Future<VacationRentalPlatform> execute(String id, VacationRentalPlatform vacationRentalPlatform) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, vacationRentalPlatform);
  }
}

class DeleteVacationRentalPlatformUseCase {
  final VacationRentalPlatformService _service;
  
  DeleteVacationRentalPlatformUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// VacationRentalPlatform Use Case Container
class VacationRentalPlatformUseCases {
  final GetVacationRentalPlatformByIdUseCase getById;
  final GetVacationRentalPlatformsUseCase getAll;
  final CreateVacationRentalPlatformUseCase create;
  final UpdateVacationRentalPlatformUseCase update;
  final DeleteVacationRentalPlatformUseCase delete;
  
  VacationRentalPlatformUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory VacationRentalPlatformUseCases.create(VacationRentalPlatformService service) {
    return VacationRentalPlatformUseCases(
      getById: GetVacationRentalPlatformByIdUseCase(service),
      getAll: GetVacationRentalPlatformsUseCase(service),
      create: CreateVacationRentalPlatformUseCase(service),
      update: UpdateVacationRentalPlatformUseCase(service),
      delete: DeleteVacationRentalPlatformUseCase(service),
    );
  }
}
