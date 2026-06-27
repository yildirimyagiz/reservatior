import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/route_service.dart';
import 'package:reservatior/shared/repositories/route_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';
import 'role_management_provider.dart';

final routeServiceProvider = Provider<RouteService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return RouteService(dioClient);
});

final routeRepositoryProvider = Provider<RouteRepository>((ref) {
  final service = ref.watch(routeServiceProvider);
  return RouteRepositoryImpl(service);
});

final routeListProvider = FutureProvider.autoDispose<List<Route>>((ref) async {
  final repository = ref.watch(routeRepositoryProvider);
  return repository.getAll();
});

final routeCreateProvider = StateProvider<Route?>((ref) => null);
final routeUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final routeDeleteProvider = StateProvider<String?>((ref) => null);
final routeLoadingProvider = StateProvider<bool>((ref) => false);

// Role-based route provider
final roleBasedRouteListProvider = Provider<List<NavigationItem>>((ref) {
  final roleManager = ref.watch(roleManagementProvider.notifier);
  return roleManager.getAvailableNavigation();
});

// Route access checker
final routeAccessProvider = Provider.family<bool, String>((ref, route) {
  final routeGuard = ref.watch(routeGuardProvider);
  return routeGuard.canAccessRoute(route);
});

// Protected route provider - returns only routes user can access
final protectedRouteListProvider = Provider<List<NavigationItem>>((ref) {
  final allRoutes = ref.watch(roleBasedRouteListProvider);
  final routeGuard = ref.watch(routeGuardProvider);
  
  return allRoutes.where((route) => routeGuard.canAccessRoute(route.route)).toList();
});
