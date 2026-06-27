import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/marketing_campaign_service.dart';
import 'package:reservatior/shared/repositories/marketing_campaign_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final marketingCampaignServiceProvider = Provider<MarketingCampaignService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return MarketingCampaignService(dioClient);
});

final marketingCampaignRepositoryProvider = Provider<MarketingCampaignRepository>((ref) {
  final service = ref.watch(marketingCampaignServiceProvider);
  return MarketingCampaignRepositoryImpl(service);
});

final marketingCampaignListProvider = FutureProvider.autoDispose<List<MarketingCampaign>>((ref) async {
  final repository = ref.watch(marketingCampaignRepositoryProvider);
  return repository.getAll();
});

final marketingCampaignCreateProvider = StateProvider<MarketingCampaign?>((ref) => null);
final marketingCampaignUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final marketingCampaignDeleteProvider = StateProvider<String?>((ref) => null);
final marketingCampaignLoadingProvider = StateProvider<bool>((ref) => false);
