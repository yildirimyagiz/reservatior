import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:reservatior/core/theme/app_theme.dart';

// ---------------------------------------------------------------------------
// Reports Suite — Overview / Exports / Scheduled tabs
// ---------------------------------------------------------------------------

class ReportsSuiteScreen extends ConsumerStatefulWidget {
  final int initialTab;
  const ReportsSuiteScreen({super.key, this.initialTab = 0});

  @override
  ConsumerState<ReportsSuiteScreen> createState() => _ReportsSuiteScreenState();
}

class _ReportsSuiteScreenState extends ConsumerState<ReportsSuiteScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: 3, vsync: this, initialIndex: widget.initialTab);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBg,
      body: NestedScrollView(
        headerSliverBuilder: (context, _) => [
          SliverAppBar(
            pinned: true,
            backgroundColor: AppColors.darkBg,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
              onPressed: () => context.pop(),
            ),
            title: Text(
              'Reports Suite',
              style: GoogleFonts.outfit(
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.download_outlined, color: AppColors.primary),
                tooltip: 'Export',
                onPressed: () {},
              ),
            ],
            bottom: TabBar(
              controller: _tabController,
              indicatorColor: AppColors.primary,
              labelColor: AppColors.primary,
              unselectedLabelColor: Colors.white38,
              labelStyle: GoogleFonts.outfit(fontWeight: FontWeight.w600),
              tabs: const [
                Tab(text: 'Overview'),
                Tab(text: 'Exports'),
                Tab(text: 'Scheduled'),
              ],
            ),
          ),
        ],
        body: TabBarView(
          controller: _tabController,
          children: const [
            _OverviewTab(),
            _ExportsTab(),
            _ScheduledTab(),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Overview Tab
// ---------------------------------------------------------------------------

class _OverviewTab extends StatelessWidget {
  const _OverviewTab();

  @override
  Widget build(BuildContext context) {
    final kpis = [
      ('Total Reports', '38', Icons.bar_chart, AppColors.primary),
      ('Generated Today', '5', Icons.today, AppColors.success),
      ('Scheduled', '12', Icons.schedule, AppColors.warning),
      ('Failed', '2', Icons.error_outline, AppColors.error),
    ];

    final recents = [
      _ReportItem(name: 'Monthly Revenue', type: 'Finance', date: 'Today 09:12', status: 'Success'),
      _ReportItem(name: 'Lead Conversion', type: 'CRM', date: 'Today 08:45', status: 'Success'),
      _ReportItem(name: 'Occupancy Rate', type: 'Operations', date: 'Yesterday', status: 'Success'),
      _ReportItem(name: 'Agent Performance', type: 'Agent OS', date: 'Yesterday', status: 'Failed'),
      _ReportItem(name: 'Market Trends', type: 'Analytics', date: '2 days ago', status: 'Success'),
    ];

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 1.5,
          children: kpis
              .map((k) => Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: AppColors.darkCard,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: AppColors.darkBorder),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(k.$3, color: k.$4, size: 20),
                        const SizedBox(height: 8),
                        Text(
                          k.$2,
                          style: GoogleFonts.outfit(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            fontSize: 22,
                          ),
                        ),
                        Text(k.$1,
                            style: GoogleFonts.outfit(
                                color: Colors.white38, fontSize: 11)),
                      ],
                    ),
                  ))
              .toList(),
        ),
        const SizedBox(height: 24),
        Text(
          'Recent Reports',
          style: GoogleFonts.outfit(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 12),
        ...recents.map((r) => _ReportTile(item: r)),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Exports Tab
// ---------------------------------------------------------------------------

class _ExportsTab extends StatelessWidget {
  const _ExportsTab();

  @override
  Widget build(BuildContext context) {
    final exports = [
      _ExportItem(name: 'Q2 Revenue.xlsx', size: '2.4 MB', date: 'Today', format: 'xlsx'),
      _ExportItem(name: 'Lead Report.pdf', size: '1.1 MB', date: 'Yesterday', format: 'pdf'),
      _ExportItem(name: 'Occupancy.csv', size: '340 KB', date: '3 days ago', format: 'csv'),
      _ExportItem(name: 'Market Trends.pdf', size: '5.2 MB', date: 'Last week', format: 'pdf'),
    ];

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          'Downloaded exports',
          style: GoogleFonts.outfit(
              color: Colors.white54, fontSize: 13),
        ),
        const SizedBox(height: 16),
        ...exports.map((e) => _ExportTile(item: e)),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Scheduled Tab
// ---------------------------------------------------------------------------

class _ScheduledTab extends StatelessWidget {
  const _ScheduledTab();

  @override
  Widget build(BuildContext context) {
    final scheduled = [
      _ScheduledItem(name: 'Weekly Revenue', frequency: 'Every Monday', nextRun: 'Mon 08:00', active: true),
      _ScheduledItem(name: 'Daily Leads', frequency: 'Daily', nextRun: 'Tomorrow 07:00', active: true),
      _ScheduledItem(name: 'Monthly Summary', frequency: '1st of month', nextRun: 'Sep 1', active: false),
      _ScheduledItem(name: 'Occupancy Digest', frequency: 'Every Friday', nextRun: 'Fri 09:00', active: true),
    ];

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        ...scheduled.map((s) => _ScheduledTile(item: s)),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Models & Tiles
// ---------------------------------------------------------------------------

class _ReportItem {
  final String name;
  final String type;
  final String date;
  final String status;
  const _ReportItem(
      {required this.name,
      required this.type,
      required this.date,
      required this.status});
}

class _ReportTile extends StatelessWidget {
  final _ReportItem item;
  const _ReportTile({required this.item});

  @override
  Widget build(BuildContext context) {
    final ok = item.status == 'Success';
    final statusColor = ok ? AppColors.success : AppColors.error;
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.darkCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.darkBorder),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(Icons.description_outlined,
                color: AppColors.primary, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.name,
                    style: GoogleFonts.outfit(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 13)),
                Text('${item.type} · ${item.date}',
                    style: GoogleFonts.outfit(
                        color: Colors.white38, fontSize: 11)),
              ],
            ),
          ),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: statusColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(item.status,
                style: GoogleFonts.outfit(
                    color: statusColor,
                    fontSize: 10,
                    fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }
}

class _ExportItem {
  final String name;
  final String size;
  final String date;
  final String format;
  const _ExportItem(
      {required this.name,
      required this.size,
      required this.date,
      required this.format});
}

class _ExportTile extends StatelessWidget {
  final _ExportItem item;
  const _ExportTile({required this.item});

  Color get _formatColor {
    switch (item.format) {
      case 'pdf':
        return AppColors.error;
      case 'xlsx':
        return AppColors.success;
      default:
        return AppColors.info;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.darkCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.darkBorder),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: _formatColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              item.format.toUpperCase(),
              style: GoogleFonts.outfit(
                  color: _formatColor,
                  fontSize: 10,
                  fontWeight: FontWeight.w800),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.name,
                    style: GoogleFonts.outfit(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 13)),
                Text('${item.size} · ${item.date}',
                    style: GoogleFonts.outfit(
                        color: Colors.white38, fontSize: 11)),
              ],
            ),
          ),
          IconButton(
            icon: Icon(Icons.download_outlined,
                color: AppColors.primary, size: 20),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

class _ScheduledItem {
  final String name;
  final String frequency;
  final String nextRun;
  final bool active;
  const _ScheduledItem(
      {required this.name,
      required this.frequency,
      required this.nextRun,
      required this.active});
}

class _ScheduledTile extends StatelessWidget {
  final _ScheduledItem item;
  const _ScheduledTile({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.darkCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.darkBorder),
      ),
      child: Row(
        children: [
          Icon(Icons.schedule,
              color: item.active ? AppColors.warning : Colors.white24,
              size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.name,
                    style: GoogleFonts.outfit(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 13)),
                Text('${item.frequency} · Next: ${item.nextRun}',
                    style: GoogleFonts.outfit(
                        color: Colors.white38, fontSize: 11)),
              ],
            ),
          ),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: item.active
                  ? AppColors.success.withValues(alpha: 0.15)
                  : Colors.white12,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              item.active ? 'Active' : 'Paused',
              style: GoogleFonts.outfit(
                  color:
                      item.active ? AppColors.success : Colors.white38,
                  fontSize: 10,
                  fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }
}
