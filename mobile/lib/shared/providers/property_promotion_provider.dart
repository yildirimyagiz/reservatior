import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/property_promotion_service.dart';
import 'package:reservatior/shared/repositories/property_promotion_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final propertyPromotionServiceProvider = Provider<PropertyPromotionService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return PropertyPromotionService(dioClient);
});

final propertyPromotionRepositoryProvider = Provider<PropertyPromotionRepository>((ref) {
  final service = ref.watch(propertyPromotionServiceProvider);
  return PropertyPromotionRepositoryImpl(service);
});

final propertyPromotionListProvider = FutureProvider.autoDispose.family<List<PropertyPromotion>, String>((ref, propertyId) async {
  final repository = ref.watch(propertyPromotionRepositoryProvider);
  return repository.getAll(filters: {'propertyId': propertyId});
});

final propertyPromotionAllListProvider = FutureProvider.autoDispose<List<PropertyPromotion>>((ref) async {
  final repository = ref.watch(propertyPromotionRepositoryProvider);
  return repository.getAll();
});

final propertyPromotionCreateProvider = StateProvider<PropertyPromotion?>((ref) => null);
final propertyPromotionUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final propertyPromotionDeleteProvider = StateProvider<String?>((ref) => null);
final propertyPromotionLoadingProvider = StateProvider<bool>((ref) => false);
