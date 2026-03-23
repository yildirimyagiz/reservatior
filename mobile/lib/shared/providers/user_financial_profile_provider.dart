import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/user_financial_profile_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// UserFinancialProfile Providers

final UserFinancialProfileServiceProvider = Provider<UserFinancialProfileService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return UserFinancialProfileService(dioClient);
});

// List Provider
final userFinancialProfileProvider = FutureProvider.autoDispose<List<UserFinancialProfile>>((ref) async {
  final service = ref.watch(UserFinancialProfileServiceProvider);
  return service.getUserFinancialProfiles();
});

// Create Provider
final UserFinancialProfileCreateProvider = FutureProvider.autoDispose<UserFinancialProfile>((ref) async {
  final service = ref.watch(UserFinancialProfileServiceProvider);
  return service.createUserFinancialProfile(UserFinancialProfile());
});

// Update Provider  
final UserFinancialProfileUpdateProvider = FutureProvider.autoDispose<UserFinancialProfile>((ref) async {
  final service = ref.watch(UserFinancialProfileServiceProvider);
  final state = ref.watch(UserFinancialProfileUpdateStateProvider);
  if (state['id'] != null && state['user_financial_profile'] != null) {
    return service.updateUserFinancialProfile(state['id'], state['user_financial_profile']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final UserFinancialProfileDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(UserFinancialProfileServiceProvider);
  final state = ref.watch(UserFinancialProfileDeleteStateProvider);
  if (state != null) {
    return service.deleteUserFinancialProfile(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final UserFinancialProfileUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final UserFinancialProfileDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final UserFinancialProfileLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(userFinancialProfileProvider);
  final createAsync = ref.watch(UserFinancialProfileCreateProvider);
  final updateAsync = ref.watch(UserFinancialProfileUpdateProvider);
  final deleteAsync = ref.watch(UserFinancialProfileDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
