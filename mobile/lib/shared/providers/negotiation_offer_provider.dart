import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/negotiation_offer_service.dart';
import 'package:reservatior/shared/repositories/negotiation_offer_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final negotiationOfferServiceProvider = Provider<NegotiationOfferService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return NegotiationOfferService(dioClient);
});

final negotiationOfferRepositoryProvider = Provider<NegotiationOfferRepository>((ref) {
  final service = ref.watch(negotiationOfferServiceProvider);
  return NegotiationOfferRepositoryImpl(service);
});

final negotiationOfferListProvider = FutureProvider.autoDispose<List<NegotiationOffer>>((ref) async {
  final repository = ref.watch(negotiationOfferRepositoryProvider);
  return repository.getAll();
});

final negotiationOfferCreateProvider = StateProvider<NegotiationOffer?>((ref) => null);
final negotiationOfferUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final negotiationOfferDeleteProvider = StateProvider<String?>((ref) => null);
final negotiationOfferLoadingProvider = StateProvider<bool>((ref) => false);
