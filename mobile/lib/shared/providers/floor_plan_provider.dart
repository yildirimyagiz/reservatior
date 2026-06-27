import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/floor_plan_service.dart';
import 'package:reservatior/shared/repositories/floor_plan_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final floorPlanServiceProvider = Provider<FloorPlanService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return FloorPlanService(dioClient);
});

final floorPlanRepositoryProvider = Provider<FloorPlanRepository>((ref) {
  final service = ref.watch(floorPlanServiceProvider);
  return FloorPlanRepositoryImpl(service);
});

final floorPlanListProvider = FutureProvider.autoDispose<List<FloorPlan>>((ref) async {
  final repository = ref.watch(floorPlanRepositoryProvider);
  return repository.getAll();
});

final floorPlanCreateProvider = StateProvider<FloorPlan?>((ref) => null);
final floorPlanUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final floorPlanDeleteProvider = StateProvider<String?>((ref) => null);
final floorPlanLoadingProvider = StateProvider<bool>((ref) => false);
