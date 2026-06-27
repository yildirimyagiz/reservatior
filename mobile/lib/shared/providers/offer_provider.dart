import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/offer_service.dart';
import 'package:reservatior/shared/repositories/offer_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final offerServiceProvider = Provider<OfferService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return OfferService(dioClient);
});

final offerRepositoryProvider = Provider<OfferRepository>((ref) {
  final service = ref.watch(offerServiceProvider);
  return OfferRepositoryImpl(service);
});

final offerListProvider = FutureProvider.autoDispose<List<Offer>>((ref) async {
  final repository = ref.watch(offerRepositoryProvider);
  return repository.getAll();
});

final offerCreateProvider = StateProvider<Offer?>((ref) => null);
final offerUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final offerDeleteProvider = StateProvider<String?>((ref) => null);
final offerLoadingProvider = StateProvider<bool>((ref) => false);
