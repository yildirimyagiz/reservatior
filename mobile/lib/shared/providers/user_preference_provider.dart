import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/user_preference_service.dart';
import 'package:reservatior/shared/repositories/user_preference_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final userPreferenceServiceProvider = Provider<UserPreferenceService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return UserPreferenceService(dioClient);
});

final userPreferenceRepositoryProvider = Provider<UserPreferenceRepository>((ref) {
  final service = ref.watch(userPreferenceServiceProvider);
  return UserPreferenceRepositoryImpl(service);
});

final userPreferenceListProvider = FutureProvider.autoDispose<List<UserPreference>>((ref) async {
  final repository = ref.watch(userPreferenceRepositoryProvider);
  return repository.getAll();
});

final userPreferenceCreateProvider = StateProvider<UserPreference?>((ref) => null);
final userPreferenceUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final userPreferenceDeleteProvider = StateProvider<String?>((ref) => null);
final userPreferenceLoadingProvider = StateProvider<bool>((ref) => false);
