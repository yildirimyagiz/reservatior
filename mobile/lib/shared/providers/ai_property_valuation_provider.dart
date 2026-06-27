import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/ai_property_valuation_service.dart';
import 'package:reservatior/shared/repositories/ai_property_valuation_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final aiPropertyValuationServiceProvider = Provider<AiPropertyValuationService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return AiPropertyValuationService(dioClient);
});

final aiPropertyValuationRepositoryProvider = Provider<AiPropertyValuationRepository>((ref) {
  final service = ref.watch(aiPropertyValuationServiceProvider);
  return AiPropertyValuationRepositoryImpl(service);
});

final aiPropertyValuationListProvider = FutureProvider.autoDispose<List<AiPropertyValuation>>((ref) async {
  final repository = ref.watch(aiPropertyValuationRepositoryProvider);
  return repository.getAll();
});

final aiPropertyValuationCreateProvider = StateProvider<AiPropertyValuation?>((ref) => null);
final aiPropertyValuationUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final aiPropertyValuationDeleteProvider = StateProvider<String?>((ref) => null);
final aiPropertyValuationLoadingProvider = StateProvider<bool>((ref) => false);
