import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/appointment_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// Appointment Providers

final appointmentServiceProvider = Provider<AppointmentService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return AppointmentService(dioClient);
});

// State Providers
final appointmentCreateStateProvider = StateProvider<Appointment?>((ref) => null);
final appointmentUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final appointmentDeleteStateProvider = StateProvider<String?>((ref) => null);

// List Provider
final appointmentListProvider = FutureProvider.autoDispose<List<Appointment>>((ref) async {
  final service = ref.watch(appointmentServiceProvider);
  return service.getAppointments();
});

// Create Provider
final appointmentCreateProvider = FutureProvider.autoDispose<Appointment>((ref) async {
  final service = ref.watch(appointmentServiceProvider);
  return service.createAppointment(Appointment());
});

// Update Provider  
final appointmentUpdateProvider = FutureProvider.autoDispose<Appointment>((ref) async {
  final service = ref.watch(appointmentServiceProvider);
  final state = ref.watch(appointmentUpdateStateProvider);
  if (state['id'] != null && state['appointment'] != null) {
    return service.updateAppointment(state['id'], state['appointment']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final appointmentDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(appointmentServiceProvider);
  final state = ref.watch(appointmentDeleteStateProvider);
  if (state != null) {
    return service.deleteAppointment(state);
  }
  throw Exception('No delete ID provided');
});

// Loading Provider
final appointmentLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(appointmentListProvider);
  final createAsync = ref.watch(appointmentCreateProvider);
  final updateAsync = ref.watch(appointmentUpdateProvider);
  final deleteAsync = ref.watch(appointmentDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
