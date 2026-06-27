import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/property_offer_service.dart';
import 'package:reservatior/shared/repositories/property_offer_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final propertyOfferServiceProvider = Provider<PropertyOfferService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return PropertyOfferService(dioClient);
});

final propertyOfferRepositoryProvider = Provider<PropertyOfferRepository>((ref) {
  final service = ref.watch(propertyOfferServiceProvider);
  return PropertyOfferRepositoryImpl(service);
});

final propertyOfferListProvider = FutureProvider.autoDispose.family<List<PropertyOffer>, String>((ref, propertyId) async {
  final repository = ref.watch(propertyOfferRepositoryProvider);
  return repository.getAll(filters: {'propertyId': propertyId});
});

final propertyOfferCreateProvider = StateProvider<PropertyOffer?>((ref) => null);
final propertyOfferUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final propertyOfferDeleteProvider = StateProvider<String?>((ref) => null);
final propertyOfferLoadingProvider = StateProvider<bool>((ref) => false);
