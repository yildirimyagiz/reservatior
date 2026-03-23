import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/marketing_campaign_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// MarketingCampaign Providers

final MarketingCampaignServiceProvider = Provider<MarketingCampaignService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return MarketingCampaignService(dioClient);
});

// List Provider
final marketingCampaignProvider = FutureProvider.autoDispose<List<MarketingCampaign>>((ref) async {
  final service = ref.watch(MarketingCampaignServiceProvider);
  return service.getMarketingCampaigns();
});

// Create Provider
final MarketingCampaignCreateProvider = FutureProvider.autoDispose<MarketingCampaign>((ref) async {
  final service = ref.watch(MarketingCampaignServiceProvider);
  return service.createMarketingCampaign(MarketingCampaign());
});

// Update Provider  
final MarketingCampaignUpdateProvider = FutureProvider.autoDispose<MarketingCampaign>((ref) async {
  final service = ref.watch(MarketingCampaignServiceProvider);
  final state = ref.watch(MarketingCampaignUpdateStateProvider);
  if (state['id'] != null && state['marketing_campaign'] != null) {
    return service.updateMarketingCampaign(state['id'], state['marketing_campaign']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final MarketingCampaignDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(MarketingCampaignServiceProvider);
  final state = ref.watch(MarketingCampaignDeleteStateProvider);
  if (state != null) {
    return service.deleteMarketingCampaign(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final MarketingCampaignUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final MarketingCampaignDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final MarketingCampaignLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(marketingCampaignProvider);
  final createAsync = ref.watch(MarketingCampaignCreateProvider);
  final updateAsync = ref.watch(MarketingCampaignUpdateProvider);
  final deleteAsync = ref.watch(MarketingCampaignDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
