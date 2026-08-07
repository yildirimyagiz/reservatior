import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:reservatior/shared/enums/property_promotion_status.dart';
import 'package:reservatior/shared/enums/property_promotion_type.dart';
import 'package:reservatior/shared/models/property_promotion.dart';
import 'package:reservatior/shared/providers/property_promotion_provider.dart';

class ListingPromotionScreen extends ConsumerStatefulWidget {
  const ListingPromotionScreen({super.key});

  @override
  ConsumerState<ListingPromotionScreen> createState() =>
      _ListingPromotionScreenState();
}

class _ListingPromotionScreenState extends ConsumerState<ListingPromotionScreen> {
  PropertyPromotionStatus? _statusFilter;

  @override
  Widget build(BuildContext context) {
    final asyncPromotions = ref.watch(propertyPromotionAllListProvider);
    final promotions = asyncPromotions.value ?? <PropertyPromotion>[];

    final visible = _statusFilter == null
        ? promotions
        : promotions.where((p) => p.status == _statusFilter).toList();

    return Scaffold(
      backgroundColor: AppColors.darkBg,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: AppColors.darkBg,
            title: Text(
              'Listing Promotion',
              style: GoogleFonts.outfit(
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _FilterChip(
                      label: 'All',
                      selected: _statusFilter == null,
                      onTap: () => setState(() => _statusFilter = null),
                    ),
                    ...PropertyPromotionStatus.values.map((s) => _FilterChip(
                          label: s.name,
                          selected: _statusFilter == s,
                          onTap: () => setState(() => _statusFilter = s),
                        )),
                  ],
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                asyncPromotions.when(
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (e, _) => Text('Could not load promotions',
                      style: GoogleFonts.outfit(color: Colors.white54)),
                  data: (data) {
                    if (visible.isEmpty) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 32),
                        child: Column(
                          children: [
                            Icon(Icons.campaign_outlined, color: Colors.white24, size: 32),
                            const SizedBox(height: 10),
                            Text('No promotions here',
                                style: GoogleFonts.outfit(
                                    color: Colors.white38, fontSize: 13)),
                          ],
                        ),
                      );
                    }
                    return Column(
                      children: visible
                          .map((p) => _PromotionTile(promotion: p))
                          .toList(),
                    );
                  },
                ),
                const SizedBox(height: 40),
              ]),
            ),
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
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(label),
        selected: selected,
        onSelected: (_) => onTap(),
        backgroundColor: AppColors.darkSurface,
        selectedColor: AppColors.primary.withValues(alpha: 0.3),
        side: BorderSide(
          color: selected ? AppColors.primary : AppColors.darkBorder,
        ),
        labelStyle: GoogleFonts.outfit(
          color: selected ? Colors.white : Colors.white54,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _PromotionTile extends StatelessWidget {
  final PropertyPromotion promotion;
  const _PromotionTile({required this.promotion});

  @override
  Widget build(BuildContext context) {
    final statusColor = _statusColor(promotion.status);
    final typeColor = _typeColor(promotion.promotionType);
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.darkCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.darkBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: typeColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(_typeIcon(promotion.promotionType),
                    color: typeColor, size: 18),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      promotion.property.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.outfit(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 14),
                    ),
                    Text(
                      '${promotion.promotionType.name.replaceAll('_', ' ')} · '
                      '${promotion.property.city}',
                      style: GoogleFonts.outfit(
                          color: Colors.white38, fontSize: 11),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: statusColor.withValues(alpha: 0.4)),
                ),
                child: Text(
                  promotion.status.name,
                  style: GoogleFonts.outfit(
                      color: statusColor,
                      fontSize: 10,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Icon(Icons.local_offer_outlined, color: Colors.white24, size: 13),
              const SizedBox(width: 4),
              Text(
                '${promotion.price.toStringAsFixed(0)} ${promotion.currency}',
                style: GoogleFonts.outfit(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w700),
              ),
              const Spacer(),
              Icon(Icons.event, color: Colors.white24, size: 13),
              const SizedBox(width: 4),
              Text(
                '${DateFormat.yMMMd().format(promotion.startDate)} → '
                '${DateFormat.yMMMd().format(promotion.endDate)}',
                style: GoogleFonts.outfit(color: Colors.white24, fontSize: 11),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.autorenew,
                  color: promotion.isAutoRenew ? AppColors.success : Colors.white24,
                  size: 13),
              const SizedBox(width: 4),
              Text(
                promotion.isAutoRenew ? 'Auto-renew on' : 'No auto-renew',
                style: GoogleFonts.outfit(
                    color: promotion.isAutoRenew
                        ? AppColors.success
                        : Colors.white24,
                    fontSize: 11),
              ),
              const Spacer(),
              if (promotion.features.isNotEmpty)
                Text(
                  '${promotion.features.length} features',
                  style: GoogleFonts.outfit(color: Colors.white24, fontSize: 11),
                ),
            ],
          ),
        ],
      ).animate().fadeIn(),
    );
  }

  Color _statusColor(PropertyPromotionStatus status) {
    switch (status) {
      case PropertyPromotionStatus.ACTIVE:
        return AppColors.success;
      case PropertyPromotionStatus.INACTIVE:
        return Colors.white38;
      case PropertyPromotionStatus.EXPIRED:
        return AppColors.warning;
      case PropertyPromotionStatus.PENDING:
        return AppColors.info;
      case PropertyPromotionStatus.CANCELLED:
        return AppColors.error;
    }
  }

  Color _typeColor(PropertyPromotionType type) {
    switch (type) {
      case PropertyPromotionType.FEATURED:
        return AppColors.primary;
      case PropertyPromotionType.URGENT:
        return AppColors.error;
      case PropertyPromotionType.PRICE_REDUCED:
        return AppColors.success;
      case PropertyPromotionType.BEST_DEAL:
        return AppColors.gold;
    }
  }

  IconData _typeIcon(PropertyPromotionType type) {
    switch (type) {
      case PropertyPromotionType.FEATURED:
        return Icons.star_outline;
      case PropertyPromotionType.URGENT:
        return Icons.bolt;
      case PropertyPromotionType.PRICE_REDUCED:
        return Icons.trending_down;
      case PropertyPromotionType.BEST_DEAL:
        return Icons.workspace_premium_outlined;
    }
  }
}
