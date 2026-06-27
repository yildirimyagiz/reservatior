import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/channel_service.dart';
import 'package:reservatior/shared/repositories/channel_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final channelServiceProvider = Provider<ChannelService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return ChannelService(dioClient);
});

final channelRepositoryProvider = Provider<ChannelRepository>((ref) {
  final service = ref.watch(channelServiceProvider);
  return ChannelRepositoryImpl(service);
});

final channelListProvider = FutureProvider.autoDispose<List<Channel>>((ref) async {
  final repository = ref.watch(channelRepositoryProvider);
  return repository.getAll();
});

final channelCreateProvider = StateProvider<Channel?>((ref) => null);
final channelUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final channelDeleteProvider = StateProvider<String?>((ref) => null);
final channelLoadingProvider = StateProvider<bool>((ref) => false);
