import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/gift_card_service.dart';
import 'package:reservatior/shared/repositories/gift_card_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final giftCardServiceProvider = Provider<GiftCardService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return GiftCardService(dioClient);
});

final giftCardRepositoryProvider = Provider<GiftCardRepository>((ref) {
  final service = ref.watch(giftCardServiceProvider);
  return GiftCardRepositoryImpl(service);
});

final giftCardListProvider = FutureProvider.autoDispose<List<GiftCard>>((ref) async {
  final repository = ref.watch(giftCardRepositoryProvider);
  return repository.getAll();
});

final giftCardCreateProvider = StateProvider<GiftCard?>((ref) => null);
final giftCardUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final giftCardDeleteProvider = StateProvider<String?>((ref) => null);
final giftCardLoadingProvider = StateProvider<bool>((ref) => false);
