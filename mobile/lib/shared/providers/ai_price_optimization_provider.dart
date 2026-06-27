import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/ai_price_optimization_service.dart';
import 'package:reservatior/shared/repositories/ai_price_optimization_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final aiPriceOptimizationServiceProvider = Provider<AiPriceOptimizationService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return AiPriceOptimizationService(dioClient);
});

final aiPriceOptimizationRepositoryProvider = Provider<AiPriceOptimizationRepository>((ref) {
  final service = ref.watch(aiPriceOptimizationServiceProvider);
  return AiPriceOptimizationRepositoryImpl(service);
});

final aiPriceOptimizationListProvider = FutureProvider.autoDispose<List<AiPriceOptimization>>((ref) async {
  final repository = ref.watch(aiPriceOptimizationRepositoryProvider);
  return repository.getAll();
});

final aiPriceOptimizationCreateProvider = StateProvider<AiPriceOptimization?>((ref) => null);
final aiPriceOptimizationUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final aiPriceOptimizationDeleteProvider = StateProvider<String?>((ref) => null);
final aiPriceOptimizationLoadingProvider = StateProvider<bool>((ref) => false);
