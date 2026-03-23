import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/analytics_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// Analytics Providers

final analyticsServiceProvider = Provider<AnalyticsService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return AnalyticsService(dioClient);
});

// List Provider
final analyticsListProvider = FutureProvider.autoDispose<List<Analytics>>((ref) async {
  final service = ref.watch(analyticsServiceProvider);
  return service.getAnalyticss();
});

// Create Provider
final analyticsCreateProvider = FutureProvider.autoDispose<Analytics>((ref) async {
  final service = ref.watch(analyticsServiceProvider);
  return service.createAnalytics(Analytics());
});

// Update Provider  
final analyticsUpdateProvider = FutureProvider.autoDispose<Analytics>((ref) async {
  final service = ref.watch(analyticsServiceProvider);
  final state = ref.watch(analyticsUpdateStateProvider);
  if (state['id'] != null && state['analytics'] != null) {
    return service.updateAnalytics(state['id'], state['analytics']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final analyticsDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(analyticsServiceProvider);
  final state = ref.watch(analyticsDeleteStateProvider);
  if (state != null) {
    return service.deleteAnalytics(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final analyticsCreateStateProvider = StateProvider<Analytics?>((ref) => null);
final analyticsUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final analyticsDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final analyticsLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(analyticsListProvider);
  final createAsync = ref.watch(analyticsCreateProvider);
  final updateAsync = ref.watch(analyticsUpdateProvider);
  final deleteAsync = ref.watch(analyticsDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
