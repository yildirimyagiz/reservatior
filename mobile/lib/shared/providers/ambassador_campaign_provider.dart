import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/ambassador_campaign_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// AmbassadorCampaign Providers

final ambassadorCampaignServiceProvider = Provider<AmbassadorCampaignService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return AmbassadorCampaignService(dioClient);
});

// List Provider
final ambassadorCampaignListProvider = FutureProvider.autoDispose<List<AmbassadorCampaign>>((ref) async {
  final service = ref.watch(ambassadorCampaignServiceProvider);
  return service.getAmbassadorCampaigns();
});

// Create Provider
final ambassadorCampaignCreateProvider = FutureProvider.autoDispose<AmbassadorCampaign>((ref) async {
  final service = ref.watch(ambassadorCampaignServiceProvider);
  return service.createAmbassadorCampaign(AmbassadorCampaign());
});

// Update Provider  
final ambassadorCampaignUpdateProvider = FutureProvider.autoDispose<AmbassadorCampaign>((ref) async {
  final service = ref.watch(ambassadorCampaignServiceProvider);
  final state = ref.watch(ambassadorCampaignUpdateStateProvider);
  if (state['id'] != null && state['ambassador_campaign'] != null) {
    return service.updateAmbassadorCampaign(state['id'], state['ambassador_campaign']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final ambassadorCampaignDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(ambassadorCampaignServiceProvider);
  final state = ref.watch(ambassadorCampaignDeleteStateProvider);
  if (state != null) {
    return service.deleteAmbassadorCampaign(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final ambassadorCampaignCreateStateProvider = StateProvider<AmbassadorCampaign?>((ref) => null);
final ambassadorCampaignUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final ambassadorCampaignDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final ambassadorCampaignLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(ambassadorCampaignListProvider);
  final createAsync = ref.watch(ambassadorCampaignCreateProvider);
  final updateAsync = ref.watch(ambassadorCampaignUpdateProvider);
  final deleteAsync = ref.watch(ambassadorCampaignDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
