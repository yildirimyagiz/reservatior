import 'package:go_router/go_router.dart';
import 'package:reservatior/features/admin/admin_module_resolver.dart';

List<RouteBase> getFeatureRoutes() {
  return [
    // Catch-all for the admin module grid. Every `/admin/:model` route in
    // `AdminHubScreen` resolves to either a dedicated management screen or the
    // generic `DynamicAdminScreen` (see AdminModuleResolver).
    GoRoute(
      path: '/admin/:model',
      builder: (context, state) =>
          AdminModuleResolver.resolve(state.pathParameters['model']!),
    ),
  ];
}
