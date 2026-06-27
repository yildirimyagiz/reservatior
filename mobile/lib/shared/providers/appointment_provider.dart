import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/appointment_service.dart';
import 'package:reservatior/shared/repositories/appointment_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final appointmentServiceProvider = Provider<AppointmentService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return AppointmentService(dioClient);
});

final appointmentRepositoryProvider = Provider<AppointmentRepository>((ref) {
  final service = ref.watch(appointmentServiceProvider);
  return AppointmentRepositoryImpl(service);
});

final appointmentListProvider = FutureProvider.autoDispose<List<Appointment>>((ref) async {
  final repository = ref.watch(appointmentRepositoryProvider);
  return repository.getAll();
});

final appointmentCreateProvider = StateProvider<Appointment?>((ref) => null);
final appointmentUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final appointmentDeleteProvider = StateProvider<String?>((ref) => null);
final appointmentLoadingProvider = StateProvider<bool>((ref) => false);
