import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:reservatior/shared/enums/payment_status.dart';
import 'package:reservatior/shared/models/rent_arrears.dart';
import 'package:reservatior/shared/models/rent_schedule.dart';
import 'package:reservatior/shared/providers/rent_arrears_provider.dart';
import 'package:reservatior/shared/providers/rent_schedule_provider.dart';

class RentManagementScreen extends ConsumerStatefulWidget {
  final int initialTab;
  const RentManagementScreen({super.key, this.initialTab = 0});

  @override
  ConsumerState<RentManagementScreen> createState() =>
      _RentManagementScreenState();
}

class _RentManagementScreenState extends ConsumerState<RentManagementScreen> {
  late int _tab;

  @override
  void initState() {
    super.initState();
    _tab = widget.initialTab;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBg,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: AppColors.darkBg,
            title: Text(
              'Rent Management',
              style: GoogleFonts.outfit(
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
              child: SegmentedButton<int>(
                segments: const [
                  ButtonSegment(
                    value: 0,
                    label: Text('Schedule'),
                    icon: Icon(Icons.event_repeat),
                  ),
                  ButtonSegment(
                    value: 1,
                    label: Text('Arrears'),
                    icon: Icon(Icons.warning_amber),
                  ),
                ],
                selected: {_tab},
                onSelectionChanged: (s) => setState(() => _tab = s.first),
                style: SegmentedButton.styleFrom(
                  backgroundColor: AppColors.darkCard,
                  foregroundColor: Colors.white70,
                  selectedBackgroundColor: AppColors.primary,
                  selectedForegroundColor: Colors.white,
                  side: const BorderSide(color: AppColors.darkBorder),
                ),
              ),
            ),
          ),
          if (_tab == 0) const _RentSchedulePanel() else const _ArrearsPanel(),
          const SliverToBoxAdapter(child: SizedBox(height: 40)),
        ],
      ),
    );
  }
}

class _RentSchedulePanel extends ConsumerWidget {
  const _RentSchedulePanel();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncSchedule = ref.watch(rentScheduleListProvider);

    return asyncSchedule.when(
      loading: () => const SliverFillRemaining(
        child: Center(child: CircularProgressIndicator()),
      ),
      error: (e, _) => SliverFillRemaining(
        child: _CenteredMessage(icon: Icons.cloud_off, title: 'Could not load rent schedule'),
      ),
      data: (schedule) {
        if (schedule.isEmpty) {
          return const SliverFillRemaining(
            child: _CenteredMessage(
              icon: Icons.event_repeat,
              title: 'No rent schedule yet',
              subtitle: 'Upcoming dues will appear here',
            ),
          );
        }
        final sorted = [...schedule]..sort((a, b) => a.dueDate.compareTo(b.dueDate));
        final upcoming = sorted
            .where((s) => s.status == PaymentStatus.UNPAID)
            .take(4)
            .toList();
        return SliverPadding(
          padding: const EdgeInsets.all(16),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              if (upcoming.isNotEmpty) ...[
                _UpcomingDues(upcoming: upcoming),
                const SizedBox(height: 16),
              ],
              for (var i = 0; i < sorted.length; i++)
                _ScheduleTile(item: sorted[i]).animate().fadeIn(delay: (40 * i).ms),
            ]),
          ),
        );
      },
    );
  }
}

class _UpcomingDues extends StatelessWidget {
  final List<RentSchedule> upcoming;
  const _UpcomingDues({required this.upcoming});

  @override
  Widget build(BuildContext context) {
    final total = upcoming.fold(0.0, (s, u) => s + u.amount);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.warning.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.warning.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.schedule_send, color: AppColors.warning, size: 20),
              const SizedBox(width: 8),
              Text('Upcoming dues',
                  style: GoogleFonts.outfit(
                      color: Colors.white,
                      fontWeight: FontWeight.w700)),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            NumberFormat.compactCurrency(symbol: '').format(total),
            style: GoogleFonts.outfit(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              fontSize: 22,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            upcoming.map((u) => DateFormat.MMMd().format(u.dueDate)).join(' · '),
            style: GoogleFonts.outfit(color: Colors.white54, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

class _ScheduleTile extends StatelessWidget {
  final RentSchedule item;
  const _ScheduleTile({required this.item});

  @override
  Widget build(BuildContext context) {
    final paid = item.status == PaymentStatus.PAID;
    final overdue = item.status == PaymentStatus.OVERDUE;
    final color = overdue
        ? AppColors.error
        : (paid ? AppColors.success : AppColors.primary);
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
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              paid ? Icons.check : (overdue ? Icons.error_outline : Icons.event),
              color: color,
              size: 18,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.lease.tenant.property.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.outfit(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Due ${DateFormat.yMMMd().format(item.dueDate)}'
                  '${item.paidAt != null ? ' · paid ${DateFormat.MMMd().format(item.paidAt!)}' : ''}',
                  style: GoogleFonts.outfit(color: Colors.white38, fontSize: 11),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                NumberFormat.compactCurrency(symbol: '').format(item.amount),
                style: GoogleFonts.outfit(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 14,
                ),
              ),
              Text(
                item.status.name,
                style: GoogleFonts.outfit(
                  color: color,
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ArrearsPanel extends ConsumerWidget {
  const _ArrearsPanel();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncArrears = ref.watch(rentArrearsListProvider);

    return asyncArrears.when(
      loading: () => const SliverFillRemaining(
        child: Center(child: CircularProgressIndicator()),
      ),
      error: (e, _) => SliverFillRemaining(
        child: _CenteredMessage(icon: Icons.cloud_off, title: 'Could not load arrears'),
      ),
      data: (arrears) {
        if (arrears.isEmpty) {
          return const SliverFillRemaining(
            child: _CenteredMessage(
              icon: Icons.task_alt,
              title: 'No arrears',
              subtitle: 'All tenants are up to date',
            ),
          );
        }
        final total = arrears.fold(0.0, (s, a) => s + a.arrearsAmount);
        return SliverPadding(
          padding: const EdgeInsets.all(16),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.error.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColors.error.withValues(alpha: 0.3)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Total arrears',
                        style: GoogleFonts.outfit(
                            color: Colors.white54, fontSize: 12)),
                    const SizedBox(height: 4),
                    Text(
                      NumberFormat.compactCurrency(symbol: '').format(total),
                      style: GoogleFonts.outfit(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 22,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '${arrears.where((a) => a.legalAction).length} with legal action',
                      style: GoogleFonts.outfit(
                          color: Colors.white54, fontSize: 12),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              for (var i = 0; i < arrears.length; i++)
                _ArrearsTile(item: arrears[i]).animate().fadeIn(delay: (40 * i).ms),
            ]),
          ),
        );
      },
    );
  }
}

class _ArrearsTile extends StatelessWidget {
  final RentArrears item;
  const _ArrearsTile({required this.item});

  @override
  Widget build(BuildContext context) {
    final hasNotice = item.noticeSent;
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.darkCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: item.legalAction
              ? AppColors.error.withValues(alpha: 0.4)
              : AppColors.darkBorder,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  item.tenant.fullName,
                  style: GoogleFonts.outfit(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
              ),
              if (item.legalAction)
                _Badge('LEGAL', AppColors.error)
              else if (hasNotice)
                _Badge('NOTICE', AppColors.warning),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            'Period ${DateFormat.yMMMd().format(item.periodStart)} – ${DateFormat.yMMMd().format(item.periodEnd)}',
            style: GoogleFonts.outfit(color: Colors.white38, fontSize: 11),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _metric('Due', item.rentDue, Colors.white),
              _metric('Paid', item.rentPaid, AppColors.success),
              _metric('Arrears', item.arrearsAmount, AppColors.error),
            ],
          ),
        ],
      ),
    );
  }

  Widget _metric(String label, double amount, Color color) {
    return Column(
      children: [
        Text(
          NumberFormat.compactCurrency(symbol: '').format(amount),
          style: GoogleFonts.outfit(
            color: color,
            fontWeight: FontWeight.w800,
            fontSize: 14,
          ),
        ),
        Text(label,
            style: GoogleFonts.outfit(color: Colors.white38, fontSize: 10)),
      ],
    );
  }
}

class _Badge extends StatelessWidget {
  final String label;
  final Color color;
  const _Badge(this.label, this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Text(
        label,
        style: GoogleFonts.outfit(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _CenteredMessage extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  const _CenteredMessage({
    required this.icon,
    required this.title,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.white38, size: 40),
            const SizedBox(height: 12),
            Text(title,
                textAlign: TextAlign.center,
                style: GoogleFonts.outfit(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                )),
            if (subtitle != null) ...[
              const SizedBox(height: 6),
              Text(subtitle!,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.outfit(
                      color: Colors.white38, fontSize: 12)),
            ],
          ],
        ),
      ),
    );
  }
}
