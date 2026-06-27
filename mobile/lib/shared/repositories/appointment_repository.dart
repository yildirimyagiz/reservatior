import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/appointment_service.dart';

abstract class AppointmentRepository {
  Future<Appointment> getById(String id);
  Future<List<Appointment>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<Appointment> create(Appointment item);
  Future<Appointment> update(String id, Appointment item);
  Future<void> delete(String id);
}

class AppointmentRepositoryImpl implements AppointmentRepository {
  final AppointmentService _service;
  AppointmentRepositoryImpl(this._service);

  @override
  Future<Appointment> getById(String id) => _service.getAppointmentById(id);

  @override
  Future<List<Appointment>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getAppointments(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<Appointment> create(Appointment item) => _service.createAppointment(item);

  @override
  Future<Appointment> update(String id, Appointment item) => _service.updateAppointment(id, item);

  @override
  Future<void> delete(String id) => _service.deleteAppointment(id);
}
