import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/brand_ambassador_service.dart';
import 'package:reservatior/shared/repositories/brand_ambassador_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final brandAmbassadorServiceProvider = Provider<BrandAmbassadorService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return BrandAmbassadorService(dioClient);
});

final brandAmbassadorRepositoryProvider = Provider<BrandAmbassadorRepository>((ref) {
  final service = ref.watch(brandAmbassadorServiceProvider);
  return BrandAmbassadorRepositoryImpl(service);
});

final brandAmbassadorListProvider = FutureProvider.autoDispose<List<BrandAmbassador>>((ref) async {
  final repository = ref.watch(brandAmbassadorRepositoryProvider);
  return repository.getAll();
});

final brandAmbassadorCreateProvider = StateProvider<BrandAmbassador?>((ref) => null);
final brandAmbassadorUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final brandAmbassadorDeleteProvider = StateProvider<String?>((ref) => null);
final brandAmbassadorLoadingProvider = StateProvider<bool>((ref) => false);
