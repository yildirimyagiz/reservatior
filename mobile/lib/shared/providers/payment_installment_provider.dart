import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/payment_installment_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// PaymentInstallment Providers

final PaymentInstallmentServiceProvider = Provider<PaymentInstallmentService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return PaymentInstallmentService(dioClient);
});

// List Provider
final paymentInstallmentProvider = FutureProvider.autoDispose<List<PaymentInstallment>>((ref) async {
  final service = ref.watch(PaymentInstallmentServiceProvider);
  return service.getPaymentInstallments();
});

// Create Provider
final PaymentInstallmentCreateProvider = FutureProvider.autoDispose<PaymentInstallment>((ref) async {
  final service = ref.watch(PaymentInstallmentServiceProvider);
  return service.createPaymentInstallment(PaymentInstallment());
});

// Update Provider  
final PaymentInstallmentUpdateProvider = FutureProvider.autoDispose<PaymentInstallment>((ref) async {
  final service = ref.watch(PaymentInstallmentServiceProvider);
  final state = ref.watch(PaymentInstallmentUpdateStateProvider);
  if (state['id'] != null && state['payment_installment'] != null) {
    return service.updatePaymentInstallment(state['id'], state['payment_installment']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final PaymentInstallmentDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(PaymentInstallmentServiceProvider);
  final state = ref.watch(PaymentInstallmentDeleteStateProvider);
  if (state != null) {
    return service.deletePaymentInstallment(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final PaymentInstallmentUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final PaymentInstallmentDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final PaymentInstallmentLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(paymentInstallmentProvider);
  final createAsync = ref.watch(PaymentInstallmentCreateProvider);
  final updateAsync = ref.watch(PaymentInstallmentUpdateProvider);
  final deleteAsync = ref.watch(PaymentInstallmentDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
