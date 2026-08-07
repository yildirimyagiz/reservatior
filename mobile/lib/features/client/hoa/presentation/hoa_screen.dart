import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:reservatior/core/theme/app_theme.dart';

class HoaScreen extends StatefulWidget {
  const HoaScreen({super.key});

  @override
  State<HoaScreen> createState() => _HoaScreenState();
}

class _HoaScreenState extends State<HoaScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
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
            title: Text('HOA', style: GoogleFonts.outfit(fontWeight: FontWeight.w800, color: Colors.white)),
            bottom: TabBar(
              controller: _tabController,
              indicatorColor: AppColors.primary,
              labelColor: AppColors.primary,
              unselectedLabelColor: Colors.white38,
              labelStyle: GoogleFonts.outfit(fontWeight: FontWeight.w600),
              tabs: const [Tab(text: 'Overview'), Tab(text: 'Dues'), Tab(text: 'Violations')],
            ),
          ),
        ],
        body: TabBarView(
          controller: _tabController,
          children: const [_HoaOverviewTab(), _HoaDuesTab(), _HoaViolationsTab()],
        ),
      ),
    );
  }
}

class _HoaOverviewTab extends StatelessWidget {
  const _HoaOverviewTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _HoaKpiRow(),
        const SizedBox(height: 20),
        Text('Community Rules', style: GoogleFonts.outfit(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 15)),
        const SizedBox(height: 10),
        _RuleTile('Quiet hours: 10 PM – 8 AM', Icons.nightlight_outlined),
        _RuleTile('No short-term rentals < 30 days', Icons.block_outlined),
        _RuleTile('Pets allowed (max 2, < 25 kg)', Icons.pets_outlined),
        _RuleTile('Common area usage: 7 AM – 10 PM', Icons.meeting_room_outlined),
        _RuleTile('Trash: Tue & Fri mornings only', Icons.delete_outline),
      ],
    );
  }
}

class _HoaKpiRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      _HoaKpi('Monthly Dues', '\$340', AppColors.primary),
      const SizedBox(width: 12),
      _HoaKpi('Balance', '\$0.00', AppColors.success),
      const SizedBox(width: 12),
      _HoaKpi('Open Violations', '0', AppColors.success),
    ]);
  }
}

class _HoaKpi extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  const _HoaKpi(this.label, this.value, this.color);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.darkCard,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.darkBorder),
        ),
        child: Column(
          children: [
            Text(value, style: GoogleFonts.outfit(color: color, fontWeight: FontWeight.w800, fontSize: 17)),
            const SizedBox(height: 2),
            Text(label, style: GoogleFonts.outfit(color: Colors.white38, fontSize: 10), textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}

class _RuleTile extends StatelessWidget {
  final String rule;
  final IconData icon;
  const _RuleTile(this.rule, this.icon);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.darkCard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.darkBorder),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white38, size: 16),
          const SizedBox(width: 12),
          Expanded(child: Text(rule, style: GoogleFonts.outfit(color: Colors.white70, fontSize: 13))),
        ],
      ),
    );
  }
}

class _HoaDuesTab extends StatelessWidget {
  const _HoaDuesTab();

  @override
  Widget build(BuildContext context) {
    final dues = [
      ('Aug 2026', '\$340', 'Paid', AppColors.success),
      ('Jul 2026', '\$340', 'Paid', AppColors.success),
      ('Jun 2026', '\$340', 'Paid', AppColors.success),
      ('May 2026', '\$340', 'Overdue', AppColors.error),
      ('Apr 2026', '\$340', 'Paid', AppColors.success),
    ];
    return ListView(
      padding: const EdgeInsets.all(16),
      children: dues
          .map((d) => Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  color: AppColors.darkCard,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColors.darkBorder),
                ),
                child: Row(children: [
                  Expanded(child: Text(d.$1, style: GoogleFonts.outfit(color: Colors.white, fontWeight: FontWeight.w600))),
                  Text(d.$2, style: GoogleFonts.outfit(color: Colors.white70, fontWeight: FontWeight.w700)),
                  const SizedBox(width: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                    decoration: BoxDecoration(color: d.$4.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(20)),
                    child: Text(d.$3, style: GoogleFonts.outfit(color: d.$4, fontSize: 10, fontWeight: FontWeight.w700)),
                  ),
                ]),
              ))
          .toList(),
    );
  }
}

class _HoaViolationsTab extends StatelessWidget {
  const _HoaViolationsTab();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check_circle_outline, color: AppColors.success, size: 52),
          const SizedBox(height: 12),
          Text('No open violations', style: GoogleFonts.outfit(color: Colors.white54, fontSize: 14)),
        ],
      ),
    );
  }
}
