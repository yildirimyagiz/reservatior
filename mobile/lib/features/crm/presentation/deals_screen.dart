import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:reservatior/shared/enums/deal_status_usa.dart';
import 'package:reservatior/shared/models/deal.dart';
import 'package:reservatior/shared/providers/deal_provider.dart';

class DealsScreen extends ConsumerStatefulWidget {
  const DealsScreen({super.key});

  @override
  ConsumerState<DealsScreen> createState() => _DealsScreenState();
}

class _DealsScreenState extends ConsumerState<DealsScreen> {
  DealStatusUSA? _filter;
  bool _refreshing = false;

  Future<void> _refresh() async {
    setState(() => _refreshing = true);
    ref.invalidate(dealListProvider);
    await ref.read(dealListProvider.future).catchError((_) => <Deal>[]);
    if (mounted) setState(() => _refreshing = false);
  }

  @override
  Widget build(BuildContext context) {
    final asyncDeals = ref.watch(dealListProvider);

    return Scaffold(
      backgroundColor: AppColors.darkBg,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: AppColors.darkBg,
            title: Text(
              'Deals',
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
                    _FilterChip(
                      label: 'All',
                      selected: _filter == null,
                      onTap: () => setState(() => _filter = null),
                    ),
                    const SizedBox(width: 8),
                    ...DealStatusUSA.values.map(
                      (s) => Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: _FilterChip(
                          label: s.name.replaceAll('_', ' '),
                          selected: _filter == s,
                          onTap: () => setState(() => _filter = s),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          asyncDeals.when(
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
                        'Could not load deals',
                        style: GoogleFonts.outfit(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextButton(
                          onPressed: _refresh, child: const Text('Retry')),
                    ],
                  ),
                ),
              ),
            ),
            data: (deals) {
              final filtered = _filter == null
                  ? deals
                  : deals.where((d) => d.dealStatus == _filter).toList();
              if (filtered.isEmpty) {
                return SliverFillRemaining(
                  child: Center(
                    child: Text(
                      'No deals yet',
                      style: GoogleFonts.outfit(color: Colors.white54),
                    ),
                  ),
                );
              }
              return SliverPadding(
                padding: const EdgeInsets.all(16),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => _DealCard(deal: filtered[index])
                        .animate()
                        .fadeIn(delay: (40 * index).ms),
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

class _FilterChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;
  const _FilterChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(label),
      selected: selected,
      onSelected: (_) => onTap(),
      selectedColor: AppColors.primary,
      backgroundColor: AppColors.darkCard,
      labelStyle: GoogleFonts.outfit(color: Colors.white, fontSize: 12),
    );
  }
}

class _DealCard extends StatelessWidget {
  final Deal deal;
  const _DealCard({required this.deal});

  Color get _color => switch (deal.dealStatus) {
        DealStatusUSA.CLOSED => AppColors.success,
        DealStatusUSA.UNDER_CONTRACT ||
        DealStatusUSA.CONTINGENT ||
        DealStatusUSA.PENDING_CLOSING =>
          AppColors.primary,
        DealStatusUSA.FALLEN_THROUGH ||
        DealStatusUSA.CANCELLED =>
          AppColors.error,
        DealStatusUSA.ON_HOLD => AppColors.warning,
        _ => Colors.white54,
      };

  @override
  Widget build(BuildContext context) {
    final clientName = deal.client?.fullName;
    final propertyName = deal.property?.name ?? deal.listing?.title;
    final price = deal.salePrice ?? deal.offerPrice;

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
                  propertyName ?? 'Deal ${deal.id.substring(0, 8)}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.outfit(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: _color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: _color.withValues(alpha: 0.4)),
                ),
                child: Text(
                  deal.dealStatus.name.replaceAll('_', ' '),
                  style: GoogleFonts.outfit(
                    color: _color,
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          if (clientName != null) ...[
            const SizedBox(height: 6),
            Row(
              children: [
                Icon(Icons.person_outline, size: 14, color: Colors.white38),
                const SizedBox(width: 4),
                Text(
                  clientName!,
                  style: GoogleFonts.outfit(
                      color: Colors.white54, fontSize: 12),
                ),
              ],
            ),
          ],
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (price != null)
                Text(
                  NumberFormat.compactCurrency(symbol: '').format(price),
                  style: GoogleFonts.outfit(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 16,
                  ),
                )
              else
                Text(
                  deal.dealType ?? 'Deal',
                  style: GoogleFonts.outfit(color: Colors.white38, fontSize: 12),
                ),
              if (deal.closingDate != null)
                Text(
                  'Closes ${DateFormat.yMMMd().format(deal.closingDate!)}',
                  style: GoogleFonts.outfit(
                      color: Colors.white38, fontSize: 11),
                ),
            ],
          ),
          if (deal.commissionAmount != null) ...[
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.percent, size: 14, color: AppColors.gold),
                const SizedBox(width: 4),
                Text(
                  'Commission ${deal.commissionAmount!.toStringAsFixed(0)}'
                  '${deal.commissionRate != null ? ' (${deal.commissionRate!.toStringAsFixed(1)}%)' : ''}',
                  style: GoogleFonts.outfit(
                      color: Colors.white54, fontSize: 12),
                ),
              ],
            ),
          ],
          if (deal.documents.isNotEmpty || deal.payouts.isNotEmpty) ...[
            const SizedBox(height: 8),
            Row(
              children: [
                if (deal.documents.isNotEmpty) ...[
                  Icon(Icons.description_outlined,
                      size: 14, color: Colors.white38),
                  const SizedBox(width: 4),
                  Text('${deal.documents.length} docs',
                      style: GoogleFonts.outfit(
                          color: Colors.white38, fontSize: 11)),
                ],
                if (deal.payouts.isNotEmpty) ...[
                  const SizedBox(width: 12),
                  Icon(Icons.payments_outlined,
                      size: 14, color: Colors.white38),
                  const SizedBox(width: 4),
                  Text('${deal.payouts.length} payouts',
                      style: GoogleFonts.outfit(
                          color: Colors.white38, fontSize: 11)),
                ],
              ],
            ),
          ],
        ],
      ),
    );
  }
}
