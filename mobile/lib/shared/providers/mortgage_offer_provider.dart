import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/mortgage_offer_service.dart';
import 'package:reservatior/shared/repositories/mortgage_offer_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final mortgageOfferServiceProvider = Provider<MortgageOfferService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return MortgageOfferService(dioClient);
});

final mortgageOfferRepositoryProvider = Provider<MortgageOfferRepository>((ref) {
  final service = ref.watch(mortgageOfferServiceProvider);
  return MortgageOfferRepositoryImpl(service);
});

final mortgageOfferListProvider = FutureProvider.autoDispose<List<MortgageOffer>>((ref) async {
  final repository = ref.watch(mortgageOfferRepositoryProvider);
  return repository.getAll();
});

final mortgageOfferCreateProvider = StateProvider<MortgageOffer?>((ref) => null);
final mortgageOfferUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final mortgageOfferDeleteProvider = StateProvider<String?>((ref) => null);
final mortgageOfferLoadingProvider = StateProvider<bool>((ref) => false);
