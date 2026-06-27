import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/discount_service.dart';
import 'package:reservatior/shared/repositories/discount_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final discountServiceProvider = Provider<DiscountService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return DiscountService(dioClient);
});

final discountRepositoryProvider = Provider<DiscountRepository>((ref) {
  final service = ref.watch(discountServiceProvider);
  return DiscountRepositoryImpl(service);
});

final discountListProvider = FutureProvider.autoDispose<List<Discount>>((ref) async {
  final repository = ref.watch(discountRepositoryProvider);
  return repository.getAll();
});

final discountCreateProvider = StateProvider<Discount?>((ref) => null);
final discountUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final discountDeleteProvider = StateProvider<String?>((ref) => null);
final discountLoadingProvider = StateProvider<bool>((ref) => false);
