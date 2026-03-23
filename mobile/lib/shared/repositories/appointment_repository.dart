import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/repository_exception.dart';

/// Repository for Appointment operations
/// Provides CRUD operations with proper error handling and type safety
class AppointmentRepository {
  final DioClient _dioClient;

  AppointmentRepository(this._dioClient);

  /// Get Appointment by ID
  /// Returns [Appointment] if found, throws [RepositoryException] otherwise
  Future<Appointment> getAppointmentById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/appointment/$id');
      if (response.statusCode == 200) {
        return Appointment.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to fetch appointment',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.notFound,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all appointments with pagination and filtering
  /// Returns list of [Appointment] objects
  Future<List<Appointment>> getappointments({
    int page = 1,
    int limit = 20,
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'page': page,
        'limit': limit,
        if (sortBy != null) 'sort_by': sortBy,
        if (sortOrder != null) 'sort_order': sortOrder,
        ...?filters,
      };
      
      final response = await _dioClient.get('/api/v1/appointment', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => Appointment.fromJson(item)).toList();
      } else {
        throw RepositoryException(
          message: 'Failed to fetch appointments',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new Appointment
  /// Returns created [Appointment] object
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
    // Implement error handling logic here
    return Exception('API Error: ${e.message}');
  }
}
