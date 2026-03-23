import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/route_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// Route Providers

final RouteServiceProvider = Provider<RouteService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return RouteService(dioClient);
});

// List Provider
final routeProvider = FutureProvider.autoDispose<List<Route>>((ref) async {
  final service = ref.watch(RouteServiceProvider);
  return service.getRoutes();
});

// Create Provider
final RouteCreateProvider = FutureProvider.autoDispose<Route>((ref) async {
  final service = ref.watch(RouteServiceProvider);
  return service.createRoute(Route());
});

// Update Provider  
final RouteUpdateProvider = FutureProvider.autoDispose<Route>((ref) async {
  final service = ref.watch(RouteServiceProvider);
  final state = ref.watch(RouteUpdateStateProvider);
  if (state['id'] != null && state['route'] != null) {
    return service.updateRoute(state['id'], state['route']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final RouteDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(RouteServiceProvider);
  final state = ref.watch(RouteDeleteStateProvider);
  if (state != null) {
    return service.deleteRoute(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final RouteUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final RouteDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final RouteLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(routeProvider);
  final createAsync = ref.watch(RouteCreateProvider);
  final updateAsync = ref.watch(RouteUpdateProvider);
  final deleteAsync = ref.watch(RouteDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
