import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/shared/services/payment_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';


final paymentServiceProvider = Provider<PaymentService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return PaymentService(dioClient);
});

final paymentListProvider = FutureProvider.autoDispose<List<Payment>>((ref) async {
  final service = ref.watch(paymentServiceProvider);
  return service.getAll();
});

final paymentCreateProvider = FutureProvider.autoDispose<Payment>((ref) async {
  final service = ref.watch(paymentServiceProvider);
  final state = ref.watch(paymentCreateStateProvider);
  if (state != null) {
    return service.create(state);
  }
  throw Exception('No create data provided');
});

final paymentUpdateProvider = FutureProvider.autoDispose<Payment>((ref) async {
  final service = ref.watch(paymentServiceProvider);
  final state = ref.watch(paymentUpdateStateProvider);
  if (state['id'] != null && state['data'] != null) {
    return service.update(state['id'], state['data']);
  }
  throw Exception('No update data provided');
});

final paymentDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(paymentServiceProvider);
  final state = ref.watch(paymentDeleteStateProvider);
  if (state != null) {
    return service.delete(state);
  }
  throw Exception('No delete ID provided');
});

final paymentCreateStateProvider = StateProvider<Payment?>((ref) => null);
final paymentUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final paymentDeleteStateProvider = StateProvider<String?>((ref) => null);

final paymentLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(paymentListProvider);
  final createAsync = ref.watch(paymentCreateProvider);
  final updateAsync = ref.watch(paymentUpdateProvider);
  final deleteAsync = ref.watch(paymentDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
