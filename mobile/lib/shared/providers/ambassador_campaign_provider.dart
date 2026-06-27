import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/ambassador_campaign_service.dart';
import 'package:reservatior/shared/repositories/ambassador_campaign_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final ambassadorCampaignServiceProvider = Provider<AmbassadorCampaignService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return AmbassadorCampaignService(dioClient);
});

final ambassadorCampaignRepositoryProvider = Provider<AmbassadorCampaignRepository>((ref) {
  final service = ref.watch(ambassadorCampaignServiceProvider);
  return AmbassadorCampaignRepositoryImpl(service);
});

final ambassadorCampaignListProvider = FutureProvider.autoDispose<List<AmbassadorCampaign>>((ref) async {
  final repository = ref.watch(ambassadorCampaignRepositoryProvider);
  return repository.getAll();
});

final ambassadorCampaignCreateProvider = StateProvider<AmbassadorCampaign?>((ref) => null);
final ambassadorCampaignUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final ambassadorCampaignDeleteProvider = StateProvider<String?>((ref) => null);
final ambassadorCampaignLoadingProvider = StateProvider<bool>((ref) => false);
