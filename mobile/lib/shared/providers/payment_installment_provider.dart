import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/payment_installment_service.dart';
import 'package:reservatior/shared/repositories/payment_installment_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final paymentInstallmentServiceProvider = Provider<PaymentInstallmentService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return PaymentInstallmentService(dioClient);
});

final paymentInstallmentRepositoryProvider = Provider<PaymentInstallmentRepository>((ref) {
  final service = ref.watch(paymentInstallmentServiceProvider);
  return PaymentInstallmentRepositoryImpl(service);
});

final paymentInstallmentListProvider = FutureProvider.autoDispose<List<PaymentInstallment>>((ref) async {
  final repository = ref.watch(paymentInstallmentRepositoryProvider);
  return repository.getAll();
});

final paymentInstallmentCreateProvider = StateProvider<PaymentInstallment?>((ref) => null);
final paymentInstallmentUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final paymentInstallmentDeleteProvider = StateProvider<String?>((ref) => null);
final paymentInstallmentLoadingProvider = StateProvider<bool>((ref) => false);
