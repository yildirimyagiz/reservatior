// lib/main.dart  ← REPLACE existing main.dart with this
// Changes: added routes for notifications, messages, Message thread,
//          AI chat, escrow, and settings screens.

import 'package:flutter/material.dart';
import './core/services/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import './core/theme/app_theme.dart';
import './shared/providers/app_providers.dart';
import './features/dosyalar/reelstate_missing/models/ai_chat_model.dart';

// Existing screens
import './features/auth/presentation/screens/login_screen.dart';
import 'features/home/presentation/pages/feed_screen.dart';
import 'features/home/presentation/pages/explore_screen.dart';
import 'features/home/presentation/pages/upload_screen.dart';
import './features/auth/presentation/screens/profile_screen.dart';
import './features/properties/presentation/screens/property_detail_screen.dart';
import 'features/properties/presentation/screens/property_analytics_screen.dart';
import 'features/home/presentation/pages/stories_screen.dart';
import 'features/home/presentation/widgets/common/main_shell.dart';

// NEW screens
import './features/notifications/presentation/screens/notifications_screen.dart';
import './features/messages/presentation/screens/messages_screen.dart';
import './features/messages/message_thread_screen.dart';
import './features/ai_chat/presentation/screens/ai_chat_screen.dart';
import './features/escrow/presentation/screens/escrow_screen.dart';
import './features/settings/presentation/screens/settings_screen.dart';

import './generated/l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
  ));
  runApp(const ProviderScope(child: ReelStateApp()));
}

final _router = GoRouter(
  initialLocation: '/feed',
  routes: [
    // ─── Auth ──────────────────────────────────────────────────────────────
    GoRoute(path: '/login', builder: (_, __) => const LoginScreen()),

    // ─── Shell (bottom nav) ────────────────────────────────────────────────
    ShellRoute(
      builder: (context, state, child) => MainShell(child: child),
      routes: [
        GoRoute(path: '/feed', builder: (_, __) => const FeedScreen()),
        GoRoute(path: '/explore', builder: (_, __) => const ExploreScreen()),
        GoRoute(path: '/upload', builder: (_, __) => const UploadScreen()),
        GoRoute(path: '/profile', builder: (_, __) => const ProfileScreen()),
      ],
    ),

    // ─── Property ──────────────────────────────────────────────────────────
    GoRoute(
      path: '/Property/:id',
      builder: (_, state) =>
          PropertyDetailScreen(propertyId: state.pathParameters['id']!),
    ),
    GoRoute(
      path: '/Property/:id/Analytics',
      builder: (_, state) =>
          PropertyAnalyticsScreen(id: state.pathParameters['id']!),
    ),

    // ─── Stories ───────────────────────────────────────────────────────────
    GoRoute(
      path: '/stories/:agentId',
      builder: (_, state) =>
          StoriesScreen(agentId: state.pathParameters['agentId']!),
    ),

    // ─── Notifications ─────────────────────────────────────────────────────
    GoRoute(
      path: '/notifications',
      builder: (_, __) => const NotificationsScreen(),
    ),

    // ─── Messages ──────────────────────────────────────────────────────────
    GoRoute(
      path: '/messages',
      builder: (_, __) => const MessagesScreen(),
    ),
    GoRoute(
      path: '/messages/:threadId',
      builder: (_, state) =>
          MessageThreadScreen(threadId: state.pathParameters['threadId']!),
    ),

    // ─── AI Chat ───────────────────────────────────────────────────────────
    // Usage: context.push('/ai-chat')
    // Usage with extra: context.push('/ai-chat', extra: {
    //   'moduleType': AIChatModuleType.paymentNegotiation,
    //   'listingId': 'abc123',
    //   'contextHint': 'I want to discuss Payment terms for Listing abc123',
    // })
    GoRoute(
      path: '/ai-chat',
      builder: (_, state) {
        final extra = state.extra as Map<String, dynamic>?;
        return AIChatScreen(
          moduleType: (extra?['moduleType'] as AIChatModuleType?) ??
              AIChatModuleType.general,
          listingId: extra?['listingId'] as String?,
          reservationId: extra?['reservationId'] as String?,
          contextHint: extra?['contextHint'] as String?,
        );
      },
    ),

    // ─── Escrow ────────────────────────────────────────────────────────────
    // Usage: context.push('/escrow/RESERVATION_ID')
    GoRoute(
      path: '/escrow/:reservationId',
      builder: (_, state) =>
          EscrowScreen(reservationId: state.pathParameters['reservationId']!),
    ),

    // ─── Settings ──────────────────────────────────────────────────────────
    GoRoute(
      path: '/settings',
      builder: (_, __) => const SettingsScreen(),
    ),
  ],
);

class ReelStateApp extends ConsumerWidget {
  const ReelStateApp({super.key});

  
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: 'ReelState',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark(),
      locale: const Locale('en', 'US'),
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('en', 'GB'),
        Locale('tr', 'TR'),
        Locale('de', 'DE'),
        Locale('fr', 'FR'),
        Locale('es', 'ES'),
        Locale('it', 'IT'),
        Locale('pt', 'PT'),
        Locale('nl', 'NL'),
        Locale('pl', 'PL'),
        Locale('ro', 'RO'),
        Locale('ru', 'RU'),
        Locale('uk', 'UA'),
        Locale('ar', 'AE'),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      routerConfig: _router,
    );
  }
}
