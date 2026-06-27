import 'package:reservatior/shared/repositories/appointment_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetAppointmentByIdUseCase {
  final AppointmentRepository _repository;
  GetAppointmentByIdUseCase(this._repository);
  Future<Appointment> execute(String id) => _repository.getById(id);
}

class GetAppointmentsUseCase {
  final AppointmentRepository _repository;
  GetAppointmentsUseCase(this._repository);
  Future<List<Appointment>> execute({
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

class CreateAppointmentUseCase {
  final AppointmentRepository _repository;
  CreateAppointmentUseCase(this._repository);
  Future<Appointment> execute(Appointment item) => _repository.create(item);
}

class UpdateAppointmentUseCase {
  final AppointmentRepository _repository;
  UpdateAppointmentUseCase(this._repository);
  Future<Appointment> execute(String id, Appointment item) => _repository.update(id, item);
}

class DeleteAppointmentUseCase {
  final AppointmentRepository _repository;
  DeleteAppointmentUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
