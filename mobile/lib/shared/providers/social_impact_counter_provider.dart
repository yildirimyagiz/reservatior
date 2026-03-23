import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/social_impact_counter_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// SocialImpactCounter Providers

final SocialImpactCounterServiceProvider = Provider<SocialImpactCounterService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return SocialImpactCounterService(dioClient);
});

// List Provider
final socialImpactCounterProvider = FutureProvider.autoDispose<List<SocialImpactCounter>>((ref) async {
  final service = ref.watch(SocialImpactCounterServiceProvider);
  return service.getSocialImpactCounters();
});

// Create Provider
final SocialImpactCounterCreateProvider = FutureProvider.autoDispose<SocialImpactCounter>((ref) async {
  final service = ref.watch(SocialImpactCounterServiceProvider);
  return service.createSocialImpactCounter(SocialImpactCounter());
});

// Update Provider  
final SocialImpactCounterUpdateProvider = FutureProvider.autoDispose<SocialImpactCounter>((ref) async {
  final service = ref.watch(SocialImpactCounterServiceProvider);
  final state = ref.watch(SocialImpactCounterUpdateStateProvider);
  if (state['id'] != null && state['social_impact_counter'] != null) {
    return service.updateSocialImpactCounter(state['id'], state['social_impact_counter']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final SocialImpactCounterDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(SocialImpactCounterServiceProvider);
  final state = ref.watch(SocialImpactCounterDeleteStateProvider);
  if (state != null) {
    return service.deleteSocialImpactCounter(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final SocialImpactCounterUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final SocialImpactCounterDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final SocialImpactCounterLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(socialImpactCounterProvider);
  final createAsync = ref.watch(SocialImpactCounterCreateProvider);
  final updateAsync = ref.watch(SocialImpactCounterUpdateProvider);
  final deleteAsync = ref.watch(SocialImpactCounterDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
