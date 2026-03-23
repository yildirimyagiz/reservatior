import '../../features/shared/services/appointment_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for Appointment

class GetAppointmentByIdUseCase {
  final AppointmentService _service;
  
  GetAppointmentByIdUseCase(this._service);
  
  Future<Appointment> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetAppointmentsUseCase {
  final AppointmentService _service;
  
  GetAppointmentsUseCase(this._service);
  
  Future<List<Appointment>> execute({
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

class CreateAppointmentUseCase {
  final AppointmentService _service;
  
  CreateAppointmentUseCase(this._service);
  
  Future<Appointment> execute(Appointment appointment) async {
    // Add validation logic here
    return await _service.create(appointment);
  }
}

class UpdateAppointmentUseCase {
  final AppointmentService _service;
  
  UpdateAppointmentUseCase(this._service);
  
  Future<Appointment> execute(String id, Appointment appointment) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, appointment);
  }
}

class DeleteAppointmentUseCase {
  final AppointmentService _service;
  
  DeleteAppointmentUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// Appointment Use Case Container
class AppointmentUseCases {
  final GetAppointmentByIdUseCase getById;
  final GetAppointmentsUseCase getAll;
  final CreateAppointmentUseCase create;
  final UpdateAppointmentUseCase update;
  final DeleteAppointmentUseCase delete;
  
  AppointmentUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory AppointmentUseCases.create(AppointmentService service) {
    return AppointmentUseCases(
      getById: GetAppointmentByIdUseCase(service),
      getAll: GetAppointmentsUseCase(service),
      create: CreateAppointmentUseCase(service),
      update: UpdateAppointmentUseCase(service),
      delete: DeleteAppointmentUseCase(service),
    );
  }
}
