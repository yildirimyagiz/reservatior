import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/social_impact_record_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// SocialImpactRecord Providers

final SocialImpactRecordServiceProvider = Provider<SocialImpactRecordService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return SocialImpactRecordService(dioClient);
});

// List Provider
final socialImpactRecordProvider = FutureProvider.autoDispose<List<SocialImpactRecord>>((ref) async {
  final service = ref.watch(SocialImpactRecordServiceProvider);
  return service.getSocialImpactRecords();
});

// Create Provider
final SocialImpactRecordCreateProvider = FutureProvider.autoDispose<SocialImpactRecord>((ref) async {
  final service = ref.watch(SocialImpactRecordServiceProvider);
  return service.createSocialImpactRecord(SocialImpactRecord());
});

// Update Provider  
final SocialImpactRecordUpdateProvider = FutureProvider.autoDispose<SocialImpactRecord>((ref) async {
  final service = ref.watch(SocialImpactRecordServiceProvider);
  final state = ref.watch(SocialImpactRecordUpdateStateProvider);
  if (state['id'] != null && state['social_impact_record'] != null) {
    return service.updateSocialImpactRecord(state['id'], state['social_impact_record']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final SocialImpactRecordDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(SocialImpactRecordServiceProvider);
  final state = ref.watch(SocialImpactRecordDeleteStateProvider);
  if (state != null) {
    return service.deleteSocialImpactRecord(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final SocialImpactRecordUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final SocialImpactRecordDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final SocialImpactRecordLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(socialImpactRecordProvider);
  final createAsync = ref.watch(SocialImpactRecordCreateProvider);
  final updateAsync = ref.watch(SocialImpactRecordUpdateProvider);
  final deleteAsync = ref.watch(SocialImpactRecordDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
