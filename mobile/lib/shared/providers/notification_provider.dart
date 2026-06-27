import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/notification_service.dart';
import 'package:reservatior/shared/services/realtime_notification_service.dart';
import 'package:reservatior/shared/services/push_notification_service.dart';
import 'package:reservatior/shared/services/background_notification_service.dart';
import 'package:reservatior/shared/services/notification_analytics_service.dart';
import 'package:reservatior/shared/repositories/notification_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final notificationServiceProvider = Provider<NotificationService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return NotificationService(dioClient);
});

final realtimeNotificationServiceProvider = Provider<RealtimeNotificationService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  final notificationService = ref.watch(notificationServiceProvider);
  return RealtimeNotificationService(dioClient, notificationService);
});

final pushNotificationServiceProvider = Provider<PushNotificationService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return PushNotificationService(dioClient);
});

final backgroundNotificationServiceProvider = Provider<BackgroundNotificationService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return BackgroundNotificationService(dioClient);
});

final notificationAnalyticsServiceProvider = Provider<NotificationAnalyticsService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return NotificationAnalyticsService(dioClient);
});

final notificationRepositoryProvider = Provider<NotificationRepository>((ref) {
  final service = ref.watch(notificationServiceProvider);
  return NotificationRepositoryImpl(service);
});

final notificationListProvider = FutureProvider.autoDispose<List<Notification>>((ref) async {
  final repository = ref.watch(notificationRepositoryProvider);
  return repository.getAll();
});

final notificationCreateProvider = StateProvider<Notification?>((ref) => null);
final notificationUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final notificationDeleteProvider = StateProvider<String?>((ref) => null);
final notificationLoadingProvider = StateProvider<bool>((ref) => false);

final unreadNotificationsCountProvider = Provider<int>((ref) {
  final notifications = ref.watch(notificationListProvider);
  return notifications.when(
    data: (items) => items.where((n) => n.status == NotificationStatus.UNREAD).length,
    loading: () => 0,
    error: (_, __) => 0,
  );
});

// Real-time notification state
final realtimeNotificationProvider = StreamProvider<Map<String, dynamic>>((ref) {
  final realtimeService = ref.watch(realtimeNotificationServiceProvider);
  return realtimeService.eventStream;
});

// Push notification state
final pushNotificationProvider = StreamProvider<Map<String, dynamic>>((ref) {
  final pushService = ref.watch(pushNotificationServiceProvider);
  return pushService.messageStream;
});

// Notification analytics state
final notificationAnalyticsProvider = FutureProvider.autoDispose<Map<String, dynamic>>((ref) async {
  final analyticsService = ref.watch(notificationAnalyticsServiceProvider);
  return analyticsService.getNotificationAnalytics();
});

final notificationEngagementProvider = FutureProvider.autoDispose<Map<String, dynamic>>((ref) async {
  final analyticsService = ref.watch(notificationAnalyticsServiceProvider);
  return analyticsService.getEngagementMetrics(days: 30);
});

// Notification filters state
final notificationFilterProvider = StateProvider<String>((ref) => 'all');
final notificationSearchProvider = StateProvider<String>((ref) => '');
final notificationSortProvider = StateProvider<String>((ref) => 'createdAt');
final notificationSortOrderProvider = StateProvider<String>((ref) => 'desc');

// Notification settings state
final notificationSettingsProvider = FutureProvider.autoDispose<Map<String, dynamic>>((ref) async {
  // Return default settings since we removed Firebase
  return {
    'enablePush': true,
    'enableEmail': true,
    'enableSMS': false,
    'enabledTypes': ['all'],
  };
});

// Notification connection state
final notificationConnectionProvider = StateProvider<bool>((ref) => false);

// Notification sync state
final notificationSyncProvider = StateProvider<bool>((ref) => false);

// Notification background state
final notificationBackgroundProvider = StateProvider<bool>((ref) => false);

// Notification performance metrics
final notificationPerformanceProvider = FutureProvider.autoDispose<Map<String, dynamic>>((ref) async {
  final analyticsService = ref.watch(notificationAnalyticsServiceProvider);
  return analyticsService.getPerformanceMetrics();
});

// Notification delivery analytics
final notificationDeliveryProvider = FutureProvider.autoDispose<Map<String, dynamic>>((ref) async {
  final analyticsService = ref.watch(notificationAnalyticsServiceProvider);
  return analyticsService.getDeliveryAnalytics();
});

// Notification type analytics
final notificationTypeAnalyticsProvider = FutureProvider.autoDispose<Map<String, dynamic>>((ref) async {
  final analyticsService = ref.watch(notificationAnalyticsServiceProvider);
  return analyticsService.getTypeAnalytics();
});

// Notification time-based analytics
final notificationTimeAnalyticsProvider = FutureProvider.autoDispose<Map<String, dynamic>>((ref) async {
  final analyticsService = ref.watch(notificationAnalyticsServiceProvider);
  return analyticsService.getTimeBasedAnalytics(period: 'daily');
});

// Notification user behavior analytics
final notificationUserBehaviorProvider = FutureProvider.autoDispose<Map<String, dynamic>>((ref) async {
  final analyticsService = ref.watch(notificationAnalyticsServiceProvider);
  return analyticsService.getUserBehaviorAnalytics();
});

// Notification top performers
final notificationTopProvider = FutureProvider.autoDispose<List<Map<String, dynamic>>>((ref) async {
  final analyticsService = ref.watch(notificationAnalyticsServiceProvider);
  return analyticsService.getTopNotifications(metric: 'engagement', limit: 10);
});

// Notification comparative analytics
final notificationComparativeProvider = FutureProvider.autoDispose<Map<String, dynamic>>((ref) async {
  final analyticsService = ref.watch(notificationAnalyticsServiceProvider);
  final now = DateTime.now();
  final thirtyDaysAgo = now.subtract(const Duration(days: 30));
  final sixtyDaysAgo = now.subtract(const Duration(days: 60));
  
  return analyticsService.getComparativeAnalytics(
    currentPeriodStart: thirtyDaysAgo,
    currentPeriodEnd: now,
    previousPeriodStart: sixtyDaysAgo,
    previousPeriodEnd: thirtyDaysAgo,
  );
});

// Notification realtime metrics
final notificationRealtimeProvider = FutureProvider.autoDispose<Map<String, dynamic>>((ref) async {
  final analyticsService = ref.watch(notificationAnalyticsServiceProvider);
  return analyticsService.getRealtimeMetrics();
});

// Notification report generation state
final notificationReportProvider = StateProvider<Map<String, dynamic>?>((ref) => null);
final notificationReportLoadingProvider = StateProvider<bool>((ref) => false);

// Notification batch operations state
final notificationBatchProvider = StateProvider<List<String>>((ref) => []);
final notificationBatchLoadingProvider = StateProvider<bool>((ref) => false);

// Notification preferences state
final notificationPreferencesProvider = StateProvider<Map<String, dynamic>>((ref) => {
  'enablePush': true,
  'enableEmail': true,
  'enableSMS': false,
  'enabledTypes': ['message', 'property', 'booking', 'payment'],
  'quietHours': {'enabled': false, 'start': '22:00', 'end': '08:00'},
  'frequency': 'normal', // low, normal, high
});

// Notification theme state
final notificationThemeProvider = StateProvider<String>((ref) => 'system'); // system, light, dark

// Notification sound state
final notificationSoundProvider = StateProvider<bool>((ref) => true);

// Notification vibration state
final notificationVibrationProvider = StateProvider<bool>((ref) => true);

// Notification led state
final notificationLedProvider = StateProvider<bool>((ref) => true);

// Notification badge state
final notificationBadgeProvider = StateProvider<bool>((ref) => true);

// Notification preview state
final notificationPreviewProvider = StateProvider<bool>((ref) => true);

// Notification priority state
final notificationPriorityProvider = StateProvider<String>((ref) => 'normal'); // low, normal, high

// Notification category state
final notificationCategoryProvider = StateProvider<String>((ref) => 'all'); // all, messages, properties, bookings, payments, documents, system, alerts, tasks

// Notification status state
final notificationStatusProvider = StateProvider<String>((ref) => 'all'); // all, unread, read, archived

// Notification date range state
final notificationDateRangeProvider = StateProvider<Map<String, DateTime>>((ref) => {
  'start': DateTime.now().subtract(const Duration(days: 30)),
  'end': DateTime.now(),
});

// Notification pagination state
final notificationPageProvider = StateProvider<int>((ref) => 1);
final notificationLimitProvider = StateProvider<int>((ref) => 20);
final notificationHasMoreProvider = StateProvider<bool>((ref) => true);

// Notification search state
final notificationSearchActiveProvider = StateProvider<bool>((ref) => false);
final notificationSearchResultsProvider = StateProvider<List<Notification>>((ref) => []);

// Notification loading states
final notificationInitialLoadingProvider = StateProvider<bool>((ref) => true);
final notificationRefreshLoadingProvider = StateProvider<bool>((ref) => false);
final notificationLoadMoreLoadingProvider = StateProvider<bool>((ref) => false);

// Notification error states
final notificationErrorProvider = StateProvider<String?>((ref) => null);
final notificationNetworkErrorProvider = StateProvider<bool>((ref) => false);

// Notification sync states
final notificationLastSyncProvider = StateProvider<DateTime?>((ref) => null);
final notificationSyncInProgressProvider = StateProvider<bool>((ref) => false);
final notificationSyncErrorProvider = StateProvider<String?>((ref) => null);

// Notification cache states
final notificationCacheProvider = StateProvider<Map<String, Notification>>((ref) => {});
final notificationCacheTimestampProvider = StateProvider<DateTime?>((ref) => null);
final notificationCacheValidProvider = StateProvider<bool>((ref) => false);

// Notification background states
final notificationBackgroundSyncProvider = StateProvider<bool>((ref) => false);
final notificationBackgroundLastSyncProvider = StateProvider<DateTime?>((ref) => null);
final notificationBackgroundErrorProvider = StateProvider<String?>((ref) => null);

// Notification debug states
final notificationDebugEnabledProvider = StateProvider<bool>((ref) => false);
final notificationDebugLogProvider = StateProvider<List<String>>((ref) => []);
