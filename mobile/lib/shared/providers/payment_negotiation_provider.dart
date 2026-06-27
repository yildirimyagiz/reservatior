import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/payment_negotiation_service.dart';
import 'package:reservatior/shared/repositories/payment_negotiation_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final paymentNegotiationServiceProvider = Provider<PaymentNegotiationService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return PaymentNegotiationService(dioClient);
});

final paymentNegotiationRepositoryProvider = Provider<PaymentNegotiationRepository>((ref) {
  final service = ref.watch(paymentNegotiationServiceProvider);
  return PaymentNegotiationRepositoryImpl(service);
});

final paymentNegotiationListProvider = FutureProvider.autoDispose<List<PaymentNegotiation>>((ref) async {
  final repository = ref.watch(paymentNegotiationRepositoryProvider);
  return repository.getAll();
});

final paymentNegotiationCreateProvider = StateProvider<PaymentNegotiation?>((ref) => null);
final paymentNegotiationUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final paymentNegotiationDeleteProvider = StateProvider<String?>((ref) => null);
final paymentNegotiationLoadingProvider = StateProvider<bool>((ref) => false);
