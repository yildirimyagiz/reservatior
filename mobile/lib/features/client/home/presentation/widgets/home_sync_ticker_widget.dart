import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservatior/shared/providers/dashboard_summary_provider.dart';
import 'dart:async';

class HomeSyncTickerWidget extends ConsumerStatefulWidget {
  const HomeSyncTickerWidget({super.key});

  @override
  ConsumerState<HomeSyncTickerWidget> createState() => _HomeSyncTickerWidgetState();
}

class _HomeSyncTickerWidgetState extends ConsumerState<HomeSyncTickerWidget> {
  int _currentIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (mounted) {
        setState(() {
          _currentIndex = _currentIndex + 1;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  IconData _getIconForPlatform(String platform) {
    switch (platform.toLowerCase()) {
      case 'airbnb': return Icons.home_work_rounded;
      case 'zillow': return Icons.map_rounded;
      case 'gov.uk': return Icons.account_balance_rounded;
      case 'booking.com': return Icons.domain_rounded;
      default: return Icons.sync_rounded;
    }
  }

  Color _getColorForPlatform(String platform) {
    switch (platform.toLowerCase()) {
      case 'airbnb': return const Color(0xFFFF5A5F);
      case 'zillow': return const Color(0xFF006AFF);
      case 'gov.uk': return const Color(0xFF005EA5);
      case 'booking.com': return const Color(0xFF003580);
      default: return const Color(0xFF10B981);
    }
  }

  @override
  Widget build(BuildContext context) {
    final summaryAsync = ref.watch(dashboardSummaryProvider);

    return SliverToBoxAdapter(
      child: summaryAsync.when(
        data: (data) {
          final List<dynamic> events = data['syncEvents'] ?? [];
          if (events.isEmpty) return const SizedBox.shrink();

          final safeIndex = _currentIndex % events.length;
          final currentEvent = events[safeIndex];

          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.03),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.white.withOpacity(0.05)),
            ),
            child: Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Color(0xFF10B981),
                    shape: BoxShape.circle,
                  ),
                ).animate(onPlay: (c) => c.repeat()).shimmer(duration: 1.seconds),
                SizedBox(width: 12),
                Text('mobile.auto.live_sync'.tr(), style: GoogleFonts.outfit(color: Colors.white54, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1)),
                Container(width: 1, height: 12, color: Colors.white24, margin: const EdgeInsets.symmetric(horizontal: 12)),
                Expanded(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 400),
                    transitionBuilder: (Widget child, Animation<double> animation) {
                      return FadeTransition(
                        opacity: animation,
                        child: SlideTransition(
                          position: Tween<Offset>(begin: const Offset(0.0, 0.5), end: Offset.zero).animate(animation),
                          child: child,
                        ),
                      );
                    },
                    child: Row(
                      key: ValueKey<int>(safeIndex),
                      children: [
                        Icon(_getIconForPlatform(currentEvent['platform']), size: 14, color: _getColorForPlatform(currentEvent['platform'])),
                        const SizedBox(width: 6),
                        Text(
                          '${currentEvent['platform']}: ${currentEvent['action']}',
                          style: GoogleFonts.outfit(color: Colors.white70, fontSize: 12),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ).animate().fadeIn(delay: 800.ms);
        },
        loading: () => const SizedBox.shrink(),
        error: (_, __) => const SizedBox.shrink(),
      ),
    );
  }
}
