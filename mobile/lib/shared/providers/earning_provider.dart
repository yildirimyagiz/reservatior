import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/earning_service.dart';
import 'package:reservatior/shared/repositories/earning_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final earningServiceProvider = Provider<EarningService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return EarningService(dioClient);
});

final earningRepositoryProvider = Provider<EarningRepository>((ref) {
  final service = ref.watch(earningServiceProvider);
  return EarningRepositoryImpl(service);
});

final earningListProvider = FutureProvider.autoDispose<List<Earning>>((ref) async {
  final repository = ref.watch(earningRepositoryProvider);
  return repository.getAll();
});

final earningCreateProvider = StateProvider<Earning?>((ref) => null);
final earningUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final earningDeleteProvider = StateProvider<String?>((ref) => null);
final earningLoadingProvider = StateProvider<bool>((ref) => false);
