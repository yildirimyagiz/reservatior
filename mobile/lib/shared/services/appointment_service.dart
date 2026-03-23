import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class AppointmentService {
  final DioClient _dioClient;

  AppointmentService(this._dioClient);

  // Get Appointment by ID
  Future<Appointment> getAppointmentById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/appointment/$id');
      return Appointment.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all appointments
  Future<List<Appointment>> getAppointments({
    int page = 1,
    int limit = 20,
    Map<String, dynamic>? filters,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'page': page.toString(),
        'limit': limit.toString(),
      };

      if (filters != null) {
        queryParams.addAll(filters);
      }

      final response = await _dioClient.get('/api/v1/appointment', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => Appointment.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create Appointment
  Future<Appointment> createAppointment(Appointment appointment) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/appointment',
        data: appointment.toJson(),
      );
      return Appointment.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update Appointment
  Future<Appointment> updateAppointment(String id, Appointment appointment) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/appointment/$id',
        data: appointment.toJson(),
      );
      return Appointment.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete Appointment
  Future<void> deleteAppointment(String id) async {
    try {
      await _dioClient.delete('/api/v1/appointment/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
