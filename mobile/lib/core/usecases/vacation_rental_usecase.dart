import '../../features/shared/services/vacation_rental_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for VacationRental

class GetVacationRentalByIdUseCase {
  final VacationRentalService _service;
  
  GetVacationRentalByIdUseCase(this._service);
  
  Future<VacationRental> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetVacationRentalsUseCase {
  final VacationRentalService _service;
  
  GetVacationRentalsUseCase(this._service);
  
  Future<List<VacationRental>> execute({
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

class CreateVacationRentalUseCase {
  final VacationRentalService _service;
  
  CreateVacationRentalUseCase(this._service);
  
  Future<VacationRental> execute(VacationRental vacationRental) async {
    // Add validation logic here
    return await _service.create(vacationRental);
  }
}

class UpdateVacationRentalUseCase {
  final VacationRentalService _service;
  
  UpdateVacationRentalUseCase(this._service);
  
  Future<VacationRental> execute(String id, VacationRental vacationRental) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, vacationRental);
  }
}

class DeleteVacationRentalUseCase {
  final VacationRentalService _service;
  
  DeleteVacationRentalUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// VacationRental Use Case Container
class VacationRentalUseCases {
  final GetVacationRentalByIdUseCase getById;
  final GetVacationRentalsUseCase getAll;
  final CreateVacationRentalUseCase create;
  final UpdateVacationRentalUseCase update;
  final DeleteVacationRentalUseCase delete;
  
  VacationRentalUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory VacationRentalUseCases.create(VacationRentalService service) {
    return VacationRentalUseCases(
      getById: GetVacationRentalByIdUseCase(service),
      getAll: GetVacationRentalsUseCase(service),
      create: CreateVacationRentalUseCase(service),
      update: UpdateVacationRentalUseCase(service),
      delete: DeleteVacationRentalUseCase(service),
    );
  }
}
