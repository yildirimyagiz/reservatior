import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/payment_service.dart';
import 'package:reservatior/shared/services/payment_gateway_service.dart';
import 'package:reservatior/shared/repositories/payment_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final paymentServiceProvider = Provider<PaymentService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return PaymentService(dioClient);
});

final paymentRepositoryProvider = Provider<PaymentRepository>((ref) {
  final service = ref.watch(paymentServiceProvider);
  return PaymentRepositoryImpl(service);
});

final paymentListProvider = FutureProvider.autoDispose<List<Payment>>((ref) async {
  final repository = ref.watch(paymentRepositoryProvider);
  return repository.getAll();
});

final paymentCreateProvider = StateProvider<Payment?>((ref) => null);
final paymentUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final paymentDeleteProvider = StateProvider<String?>((ref) => null);
final paymentLoadingProvider = StateProvider<bool>((ref) => false);


final paymentGatewayServiceProvider = Provider<PaymentGatewayService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return PaymentGatewayService(dioClient);
});
