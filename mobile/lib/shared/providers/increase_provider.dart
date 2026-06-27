import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/increase_service.dart';
import 'package:reservatior/shared/repositories/increase_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final increaseServiceProvider = Provider<IncreaseService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return IncreaseService(dioClient);
});

final increaseRepositoryProvider = Provider<IncreaseRepository>((ref) {
  final service = ref.watch(increaseServiceProvider);
  return IncreaseRepositoryImpl(service);
});

final increaseListProvider = FutureProvider.autoDispose<List<Increase>>((ref) async {
  final repository = ref.watch(increaseRepositoryProvider);
  return repository.getAll();
});

final increaseCreateProvider = StateProvider<Increase?>((ref) => null);
final increaseUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final increaseDeleteProvider = StateProvider<String?>((ref) => null);
final increaseLoadingProvider = StateProvider<bool>((ref) => false);
