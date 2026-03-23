import '../../features/shared/services/rent_schedule_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for RentSchedule

class GetRentScheduleByIdUseCase {
  final RentScheduleService _service;
  
  GetRentScheduleByIdUseCase(this._service);
  
  Future<RentSchedule> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetRentSchedulesUseCase {
  final RentScheduleService _service;
  
  GetRentSchedulesUseCase(this._service);
  
  Future<List<RentSchedule>> execute({
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

class CreateRentScheduleUseCase {
  final RentScheduleService _service;
  
  CreateRentScheduleUseCase(this._service);
  
  Future<RentSchedule> execute(RentSchedule rentSchedule) async {
    // Add validation logic here
    return await _service.create(rentSchedule);
  }
}

class UpdateRentScheduleUseCase {
  final RentScheduleService _service;
  
  UpdateRentScheduleUseCase(this._service);
  
  Future<RentSchedule> execute(String id, RentSchedule rentSchedule) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, rentSchedule);
  }
}

class DeleteRentScheduleUseCase {
  final RentScheduleService _service;
  
  DeleteRentScheduleUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// RentSchedule Use Case Container
class RentScheduleUseCases {
  final GetRentScheduleByIdUseCase getById;
  final GetRentSchedulesUseCase getAll;
  final CreateRentScheduleUseCase create;
  final UpdateRentScheduleUseCase update;
  final DeleteRentScheduleUseCase delete;
  
  RentScheduleUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory RentScheduleUseCases.create(RentScheduleService service) {
    return RentScheduleUseCases(
      getById: GetRentScheduleByIdUseCase(service),
      getAll: GetRentSchedulesUseCase(service),
      create: CreateRentScheduleUseCase(service),
      update: UpdateRentScheduleUseCase(service),
      delete: DeleteRentScheduleUseCase(service),
    );
  }
}
