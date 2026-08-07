import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:reservatior/shared/enums/lead_status.dart';
import 'package:reservatior/shared/models/lead.dart';
import 'package:reservatior/shared/providers/lead_provider.dart';

class LeadsScreen extends ConsumerStatefulWidget {
  const LeadsScreen({super.key});

  @override
  ConsumerState<LeadsScreen> createState() => _LeadsScreenState();
}

class _LeadsScreenState extends ConsumerState<LeadsScreen> {
  LeadStatus? _filter;
  bool _refreshing = false;

  Future<void> _refresh() async {
    setState(() => _refreshing = true);
    ref.invalidate(leadListProvider);
    await ref.read(leadListProvider.future).catchError((_) => <Lead>[]);
    if (mounted) setState(() => _refreshing = false);
  }

  @override
  Widget build(BuildContext context) {
    final asyncLeads = ref.watch(leadListProvider);

    return Scaffold(
      backgroundColor: AppColors.darkBg,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: AppColors.darkBg,
            title: Text(
              'CRM Leads',
              style: GoogleFonts.outfit(
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
            actions: [
              IconButton(
                onPressed: _refreshing ? null : _refresh,
                icon: _refreshing
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.refresh, color: Colors.white70),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    FilterChip(
                      label: const Text('All'),
                      selected: _filter == null,
                      onSelected: (_) => setState(() => _filter = null),
                      selectedColor: AppColors.primary,
                      backgroundColor: AppColors.darkCard,
                      labelStyle: GoogleFonts.outfit(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(width: 8),
                    ...LeadStatus.values.map((s) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: FilterChip(
                          label: Text(s.name),
                          selected: _filter == s,
                          onSelected: (_) => setState(() => _filter = s),
                          selectedColor: AppColors.primary,
                          backgroundColor: AppColors.darkCard,
                          labelStyle: GoogleFonts.outfit(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
          ),
          asyncLeads.when(
            loading: () => const SliverFillRemaining(
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (e, _) => SliverFillRemaining(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.cloud_off, color: Colors.white38, size: 40),
                      const SizedBox(height: 12),
                      Text(
                        'Could not load leads',
                        style: GoogleFonts.outfit(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        e.toString(),
                        textAlign: TextAlign.center,
                        style: GoogleFonts.outfit(
                          color: Colors.white54,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextButton(onPressed: _refresh, child: const Text('Retry')),
                    ],
                  ),
                ),
              ),
            ),
            data: (leads) {
              final filtered = _filter == null
                  ? leads
                  : leads.where((l) => l.status == _filter).toList();
              if (filtered.isEmpty) {
                return SliverFillRemaining(
                  child: Center(
                    child: Text(
                      'No leads yet',
                      style: GoogleFonts.outfit(color: Colors.white54),
                    ),
                  ),
                );
              }
              return SliverPadding(
                padding: const EdgeInsets.all(16),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final lead = filtered[index];
                      return _LeadCard(lead: lead)
                          .animate()
                          .fadeIn(delay: (40 * index).ms);
                    },
                    childCount: filtered.length,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _LeadCard extends StatelessWidget {
  final Lead lead;
  const _LeadCard({required this.lead});

  @override
  Widget build(BuildContext context) {
    final name = [
      lead.firstName,
      lead.lastName,
    ].whereType<String>().where((e) => e.isNotEmpty).join(' ');
    final display = name.isEmpty ? (lead.email ?? 'Unknown lead') : name;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.darkCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.darkBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  display,
                  style: GoogleFonts.outfit(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
              ),
              _StatusBadge(status: lead.status),
            ],
          ),
          if (lead.email != null) ...[
            const SizedBox(height: 6),
            Text(
              lead.email!,
              style: GoogleFonts.outfit(color: Colors.white54, fontSize: 13),
            ),
          ],
          if (lead.phone != null) ...[
            const SizedBox(height: 4),
            Text(
              lead.phone!,
              style: GoogleFonts.outfit(color: Colors.white38, fontSize: 12),
            ),
          ],
          const SizedBox(height: 10),
          Row(
            children: [
              if (lead.budget != null) ...[
                Icon(Icons.payments_outlined, size: 14, color: AppColors.gold),
                const SizedBox(width: 4),
                Text(
                  NumberFormat.compactCurrency(symbol: '\$')
                      .format(lead.budget),
                  style: GoogleFonts.outfit(
                    color: Colors.white70,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 16),
              ],
              Icon(Icons.schedule, size: 14, color: Colors.white38),
              const SizedBox(width: 4),
              Text(
                DateFormat.yMMMd().format(lead.createdAt),
                style: GoogleFonts.outfit(color: Colors.white38, fontSize: 11),
              ),
            ],
          ),
          if (lead.notes != null && lead.notes!.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              lead.notes!,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.outfit(color: Colors.white54, fontSize: 12),
            ),
          ],
        ],
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final LeadStatus status;
  const _StatusBadge({required this.status});

  Color get _color => switch (status) {
        LeadStatus.NEW => AppColors.info,
        LeadStatus.CONTACTED => AppColors.primary,
        LeadStatus.QUALIFIED => AppColors.success,
        LeadStatus.CONVERTED => const Color(0xFF22C55E),
        LeadStatus.LOST => AppColors.error,
        LeadStatus.UNQUALIFIED => AppColors.warning,
        LeadStatus.NURTURE => Colors.purpleAccent,
      };

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: _color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _color.withValues(alpha: 0.4)),
      ),
      child: Text(
        status.name,
        style: GoogleFonts.outfit(
          color: _color,
          fontSize: 10,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
