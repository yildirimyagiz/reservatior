import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/notification_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// Notification Providers

final NotificationServiceProvider = Provider<NotificationService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return NotificationService(dioClient);
});

// List Provider
final notificationProvider = FutureProvider.autoDispose<List<Notification>>((ref) async {
  final service = ref.watch(NotificationServiceProvider);
  return service.getNotifications();
});

// Create Provider
final NotificationCreateProvider = FutureProvider.autoDispose<Notification>((ref) async {
  final service = ref.watch(NotificationServiceProvider);
  return service.createNotification(Notification());
});

// Update Provider  
final NotificationUpdateProvider = FutureProvider.autoDispose<Notification>((ref) async {
  final service = ref.watch(NotificationServiceProvider);
  final state = ref.watch(NotificationUpdateStateProvider);
  if (state['id'] != null && state['notification'] != null) {
    return service.updateNotification(state['id'], state['notification']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final NotificationDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(NotificationServiceProvider);
  final state = ref.watch(NotificationDeleteStateProvider);
  if (state != null) {
    return service.deleteNotification(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final NotificationUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final NotificationDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final NotificationLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(notificationProvider);
  final createAsync = ref.watch(NotificationCreateProvider);
  final updateAsync = ref.watch(NotificationUpdateProvider);
  final deleteAsync = ref.watch(NotificationDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
