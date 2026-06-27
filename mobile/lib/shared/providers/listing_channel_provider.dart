import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/listing_channel_service.dart';
import 'package:reservatior/shared/repositories/listing_channel_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final listingChannelServiceProvider = Provider<ListingChannelService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return ListingChannelService(dioClient);
});

final listingChannelRepositoryProvider = Provider<ListingChannelRepository>((ref) {
  final service = ref.watch(listingChannelServiceProvider);
  return ListingChannelRepositoryImpl(service);
});

final listingChannelListProvider = FutureProvider.autoDispose<List<ListingChannel>>((ref) async {
  final repository = ref.watch(listingChannelRepositoryProvider);
  return repository.getAll();
});

final listingChannelCreateProvider = StateProvider<ListingChannel?>((ref) => null);
final listingChannelUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final listingChannelDeleteProvider = StateProvider<String?>((ref) => null);
final listingChannelLoadingProvider = StateProvider<bool>((ref) => false);
