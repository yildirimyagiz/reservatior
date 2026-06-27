import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/deal_service.dart';
import 'package:reservatior/shared/repositories/deal_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final dealServiceProvider = Provider<DealService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return DealService(dioClient);
});

final dealRepositoryProvider = Provider<DealRepository>((ref) {
  final service = ref.watch(dealServiceProvider);
  return DealRepositoryImpl(service);
});

final dealListProvider = FutureProvider.autoDispose<List<Deal>>((ref) async {
  final repository = ref.watch(dealRepositoryProvider);
  return repository.getAll();
});

final dealCreateProvider = StateProvider<Deal?>((ref) => null);
final dealUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final dealDeleteProvider = StateProvider<String?>((ref) => null);
final dealLoadingProvider = StateProvider<bool>((ref) => false);
