import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/ai_property_description_service.dart';
import 'package:reservatior/shared/repositories/ai_property_description_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final aiPropertyDescriptionServiceProvider = Provider<AiPropertyDescriptionService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return AiPropertyDescriptionService(dioClient);
});

final aiPropertyDescriptionRepositoryProvider = Provider<AiPropertyDescriptionRepository>((ref) {
  final service = ref.watch(aiPropertyDescriptionServiceProvider);
  return AiPropertyDescriptionRepositoryImpl(service);
});

final aiPropertyDescriptionListProvider = FutureProvider.autoDispose<List<AiPropertyDescription>>((ref) async {
  final repository = ref.watch(aiPropertyDescriptionRepositoryProvider);
  return repository.getAll();
});

final aiPropertyDescriptionCreateProvider = StateProvider<AiPropertyDescription?>((ref) => null);
final aiPropertyDescriptionUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final aiPropertyDescriptionDeleteProvider = StateProvider<String?>((ref) => null);
final aiPropertyDescriptionLoadingProvider = StateProvider<bool>((ref) => false);
