import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/channel_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// Channel Providers

final ChannelServiceProvider = Provider<ChannelService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return ChannelService(dioClient);
});

// List Provider
final channelProvider = FutureProvider.autoDispose<List<Channel>>((ref) async {
  final service = ref.watch(ChannelServiceProvider);
  return service.getChannels();
});

// Create Provider
final ChannelCreateProvider = FutureProvider.autoDispose<Channel>((ref) async {
  final service = ref.watch(ChannelServiceProvider);
  return service.createChannel(Channel());
});

// Update Provider  
final ChannelUpdateProvider = FutureProvider.autoDispose<Channel>((ref) async {
  final service = ref.watch(ChannelServiceProvider);
  final state = ref.watch(ChannelUpdateStateProvider);
  if (state['id'] != null && state['channel'] != null) {
    return service.updateChannel(state['id'], state['channel']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final ChannelDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(ChannelServiceProvider);
  final state = ref.watch(ChannelDeleteStateProvider);
  if (state != null) {
    return service.deleteChannel(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final ChannelUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final ChannelDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final ChannelLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(channelProvider);
  final createAsync = ref.watch(ChannelCreateProvider);
  final updateAsync = ref.watch(ChannelUpdateProvider);
  final deleteAsync = ref.watch(ChannelDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
