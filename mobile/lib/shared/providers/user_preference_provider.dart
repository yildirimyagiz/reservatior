import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/user_preference_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// UserPreference Providers

final UserPreferenceServiceProvider = Provider<UserPreferenceService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return UserPreferenceService(dioClient);
});

// List Provider
final userPreferenceProvider = FutureProvider.autoDispose<List<UserPreference>>((ref) async {
  final service = ref.watch(UserPreferenceServiceProvider);
  return service.getUserPreferences();
});

// Create Provider
final UserPreferenceCreateProvider = FutureProvider.autoDispose<UserPreference>((ref) async {
  final service = ref.watch(UserPreferenceServiceProvider);
  return service.createUserPreference(UserPreference());
});

// Update Provider  
final UserPreferenceUpdateProvider = FutureProvider.autoDispose<UserPreference>((ref) async {
  final service = ref.watch(UserPreferenceServiceProvider);
  final state = ref.watch(UserPreferenceUpdateStateProvider);
  if (state['id'] != null && state['user_preference'] != null) {
    return service.updateUserPreference(state['id'], state['user_preference']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final UserPreferenceDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(UserPreferenceServiceProvider);
  final state = ref.watch(UserPreferenceDeleteStateProvider);
  if (state != null) {
    return service.deleteUserPreference(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final UserPreferenceUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final UserPreferenceDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final UserPreferenceLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(userPreferenceProvider);
  final createAsync = ref.watch(UserPreferenceCreateProvider);
  final updateAsync = ref.watch(UserPreferenceUpdateProvider);
  final deleteAsync = ref.watch(UserPreferenceDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
