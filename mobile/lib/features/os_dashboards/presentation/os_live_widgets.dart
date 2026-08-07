import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:reservatior/shared/providers/os_dashboard_providers.dart';

/// Reusable live-data widgets for the OS dashboards that fetch from the
/// Elysia server (`/api/v1/{osName}/dashboard`).

/// Generic live OS dashboard scaffold: pinned app bar + KPI grid + activity
/// list + alerts, all fed from an [OsDashboardStats] async value.
class OsLiveDashboardScaffold extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color accentColor;
  final AsyncValue<OsDashboardStats> stats;
  final List<OsKpiData> Function(OsDashboardStats stats) kpiBuilder;
  final String activityLabel;

  const OsLiveDashboardScaffold({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.accentColor,
    required this.stats,
    required this.kpiBuilder,
    this.activityLabel = 'Recent Activity',
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBg,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 120,
            pinned: true,
            backgroundColor: AppColors.darkBg.withValues(alpha: 0.8),
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: false,
              titlePadding: const EdgeInsets.only(left: 24, bottom: 20),
              title: Text(
                title,
                style: GoogleFonts.outfit(fontWeight: FontWeight.w800, fontSize: 22, color: Colors.white),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                stats.when(
                  loading: () => const OsLiveLoading(),
                  error: (e, _) => OsLiveErrorCard(message: 'Failed to load $title data: $e'),
                  data: (s) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      OsLiveKpiGrid(items: kpiBuilder(s)),
                      if (s.recentActivity.isNotEmpty) ...[
                        const SizedBox(height: 20),
                        OsLiveActivityList(
                          label: activityLabel,
                          items: s.recentActivity.map(osActivityFromJson).toList(),
                        ),
                      ],
                      if (s.alerts.isNotEmpty) ...[
                        const SizedBox(height: 20),
                        OsLiveAlertList(items: s.alerts),
                      ],
                    ],
                  ),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class OsKpiData {
  final String label;
  final String value;
  final IconData icon;
  final Color color;
  const OsKpiData(this.label, this.value, this.icon, this.color);
}

class OsLiveKpiGrid extends StatelessWidget {
  final List<OsKpiData> items;
  const OsLiveKpiGrid({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    final rows = <Widget>[];
    for (var i = 0; i < items.length; i += 2) {
      rows.add(Row(
        children: [
          Expanded(child: _OsLiveKpiCard(item: items[i])),
          if (i + 1 < items.length) ...[const SizedBox(width: 12), Expanded(child: _OsLiveKpiCard(item: items[i + 1]))],
        ],
      ));
      rows.add(const SizedBox(height: 12));
    }
    return Column(children: rows).animate().fadeIn().slideY();
  }
}

class _OsLiveKpiCard extends StatelessWidget {
  final OsKpiData item;
  const _OsLiveKpiCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: item.color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: item.color.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(item.icon, size: 18, color: item.color),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  item.label,
                  style: GoogleFonts.outfit(fontWeight: FontWeight.w500, fontSize: 12, color: Colors.white70),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            item.value,
            style: GoogleFonts.outfit(fontWeight: FontWeight.w800, fontSize: 22, color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class OsActivityItem {
  final String title;
  final String subtitle;
  final String value;
  final IconData icon;
  final Color color;
  const OsActivityItem({
    required this.title,
    required this.subtitle,
    required this.value,
    required this.icon,
    required this.color,
  });
}

class OsLiveActivityList extends StatelessWidget {
  final String label;
  final List<OsActivityItem> items;
  const OsLiveActivityList({super.key, required this.label, required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.cardBg.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: GoogleFonts.outfit(fontWeight: FontWeight.w600, fontSize: 16, color: Colors.white)),
          const SizedBox(height: 12),
          ...items.map(
            (item) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: [
                  Icon(item.icon, size: 18, color: item.color),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item.title, style: GoogleFonts.outfit(fontWeight: FontWeight.w600, fontSize: 14, color: Colors.white)),
                        Text(item.subtitle, style: GoogleFonts.outfit(fontSize: 12, color: Colors.white60)),
                      ],
                    ),
                  ),
                  Text(item.value, style: GoogleFonts.outfit(fontWeight: FontWeight.w700, fontSize: 13, color: item.color)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OsLiveAlertList extends StatelessWidget {
  final List<Map<String, dynamic>> items;
  const OsLiveAlertList({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: items.map((a) {
        final type = (a['type'] ?? 'info').toString();
        final color = type == 'warning' ? AppColors.warning : type == 'success' ? AppColors.success : AppColors.info;
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: color.withValues(alpha: 0.3)),
            ),
            child: Row(
              children: [
                Icon(Icons.notifications_active_outlined, color: color, size: 20),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text((a['title'] ?? '').toString(), style: GoogleFonts.outfit(fontWeight: FontWeight.w600, fontSize: 14, color: Colors.white)),
                      Text((a['message'] ?? '').toString(), style: GoogleFonts.outfit(fontSize: 12, color: Colors.white60)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}

class OsLiveErrorCard extends StatelessWidget {
  final String message;
  const OsLiveErrorCard({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.error.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.error.withValues(alpha: 0.4)),
      ),
      child: Text(message, style: GoogleFonts.outfit(fontSize: 13, color: Colors.white70)),
    );
  }
}

class OsLiveLoading extends StatelessWidget {
  const OsLiveLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 200,
      child: Center(child: CircularProgressIndicator(color: AppColors.primary)),
    );
  }
}

/// Formats a numeric KPI as a compact human string ($1.2K, $3.4M).
String osFormatCompact(num v, {String prefix = ''}) {
  if (v >= 1000000) return '$prefix${(v / 1000000).toStringAsFixed(1)}M';
  if (v >= 1000) return '$prefix${(v / 1000).toStringAsFixed(1)}K';
  return '$prefix${v.toStringAsFixed(0)}';
}

/// Maps an `OsDashboardStats.recentActivity` entry to a display item.
OsActivityItem osActivityFromJson(Map<String, dynamic> a, {IconData icon = Icons.history, Color color = AppColors.info}) {
  return OsActivityItem(
    title: (a['title'] ?? '').toString(),
    subtitle: (a['subtitle'] ?? '').toString(),
    value: (a['value'] ?? '').toString(),
    icon: icon,
    color: color,
  );
}
