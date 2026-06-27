import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/plan_service.dart';
import 'package:reservatior/shared/repositories/plan_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final planServiceProvider = Provider<PlanService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return PlanService(dioClient);
});

final planRepositoryProvider = Provider<PlanRepository>((ref) {
  final service = ref.watch(planServiceProvider);
  return PlanRepositoryImpl(service);
});

final planListProvider = FutureProvider.autoDispose<List<Plan>>((ref) async {
  final repository = ref.watch(planRepositoryProvider);
  return repository.getAll();
});

final planCreateProvider = StateProvider<Plan?>((ref) => null);
final planUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final planDeleteProvider = StateProvider<String?>((ref) => null);
final planLoadingProvider = StateProvider<bool>((ref) => false);
