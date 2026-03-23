import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/payment_negotiation_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// PaymentNegotiation Providers

final PaymentNegotiationServiceProvider = Provider<PaymentNegotiationService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return PaymentNegotiationService(dioClient);
});

// List Provider
final paymentNegotiationProvider = FutureProvider.autoDispose<List<PaymentNegotiation>>((ref) async {
  final service = ref.watch(PaymentNegotiationServiceProvider);
  return service.getPaymentNegotiations();
});

// Create Provider
final PaymentNegotiationCreateProvider = FutureProvider.autoDispose<PaymentNegotiation>((ref) async {
  final service = ref.watch(PaymentNegotiationServiceProvider);
  return service.createPaymentNegotiation(PaymentNegotiation());
});

// Update Provider  
final PaymentNegotiationUpdateProvider = FutureProvider.autoDispose<PaymentNegotiation>((ref) async {
  final service = ref.watch(PaymentNegotiationServiceProvider);
  final state = ref.watch(PaymentNegotiationUpdateStateProvider);
  if (state['id'] != null && state['payment_negotiation'] != null) {
    return service.updatePaymentNegotiation(state['id'], state['payment_negotiation']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final PaymentNegotiationDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(PaymentNegotiationServiceProvider);
  final state = ref.watch(PaymentNegotiationDeleteStateProvider);
  if (state != null) {
    return service.deletePaymentNegotiation(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final PaymentNegotiationUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final PaymentNegotiationDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final PaymentNegotiationLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(paymentNegotiationProvider);
  final createAsync = ref.watch(PaymentNegotiationCreateProvider);
  final updateAsync = ref.watch(PaymentNegotiationUpdateProvider);
  final deleteAsync = ref.watch(PaymentNegotiationDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
