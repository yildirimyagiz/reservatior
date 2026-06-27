import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:reservatior/shared/providers/theme_provider.dart';
import 'package:reservatior/shared/providers/property_viewing_provider.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class ViewingsScreen extends ConsumerWidget {
  const ViewingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = ref.watch(themeAwareColorsProvider);
    final viewingsAsync = ref.watch(propertyViewingListProvider(''));

    return Scaffold(
      backgroundColor: colors.background,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          _buildSliverAppBar(context, colors),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildMarketingHeader(colors),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
          viewingsAsync.when(
            data: (viewings) {
              if (viewings.isEmpty) {
                return SliverFillRemaining(
                  child: Center(child: Text('mobile.viewing.noViewings'.tr(), style: TextStyle(color: colors.textSecondary))),
                );
              }
              return SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final v = viewings[index];
                      return _buildViewingCard(v, colors);
                    },
                    childCount: viewings.length,
                  ),
                ),
              );
            },
            loading: () => const SliverFillRemaining(
              child: Center(child: CircularProgressIndicator(color: AppColors.primary)),
            ),
            error: (e, _) => SliverFillRemaining(
              child: Center(child: Text('${'mobile.viewing.error'.tr()}$e', style: const TextStyle(color: AppColors.error))),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        backgroundColor: AppColors.primary,
        icon: const Icon(Icons.add_rounded, color: Colors.white),
        label: Text('mobile.viewing.add'.tr(), style: GoogleFonts.outfit(fontWeight: FontWeight.bold, letterSpacing: 1)),
      ).animate().scale(delay: 500.ms),
    );
  }

  Widget _buildSliverAppBar(BuildContext context, ThemeAwareColors colors) {
    return SliverPadding(
      padding: const EdgeInsets.only(top: 16),
      sliver: SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () => context.pop(),
                icon: Icon(Icons.arrow_back_ios_new_rounded, color: colors.textPrimary, size: 20),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: colors.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: colors.border),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.calendar_month_rounded, size: 14, color: AppColors.primary),
                    SizedBox(width: 8),
                    Text(
                      'mobile.viewing.calendarView'.tr(),
                      style: GoogleFonts.outfit(
                        color: colors.textPrimary,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMarketingHeader(ThemeAwareColors colors) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.amber.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.amber.withOpacity(0.2)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.today_rounded, color: Colors.amber, size: 12),
              SizedBox(width: 6),
              Text(
                'mobile.viewing.management'.tr(),
                style: GoogleFonts.outfit(
                  color: Colors.amber,
                  fontSize: 9,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12),
        Text(
          'mobile.viewing.title'.tr(),
          style: GoogleFonts.outfit(
            color: colors.textPrimary,
            fontSize: 32,
            fontWeight: FontWeight.bold,
            letterSpacing: -0.5,
          ),
        ),
        Text(
          'mobile.viewing.desc'.tr(),
          style: GoogleFonts.outfit(
            color: colors.textSecondary,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildViewingCard(PropertyViewing v, ThemeAwareColors colors) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: colors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  '15:30', 
                  style: GoogleFonts.outfit(color: AppColors.primary, fontWeight: FontWeight.bold, fontSize: 13),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text('mobile.viewing.approved'.tr(), style: GoogleFonts.outfit(color: Colors.green, fontSize: 9, fontWeight: FontWeight.w900)),
              ),
            ],
          ),
          SizedBox(height: 16),
          Text(
            'mobile.viewing.mockProperty'.tr(),
            style: GoogleFonts.outfit(color: colors.textPrimary, fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Icon(Icons.person_pin_circle_outlined, color: colors.textSecondary.withOpacity(0.5), size: 14),
              SizedBox(width: 6),
              Text('mobile.viewing.mockLocation'.tr(), style: GoogleFonts.outfit(color: colors.textSecondary, fontSize: 12)),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(color: Colors.white10),
          const SizedBox(height: 16),
          Row(
            children: [
              CircleAvatar(
                radius: 12,
                backgroundColor: colors.background,
                child: Icon(Icons.person_2_outlined, color: colors.textSecondary, size: 12),
              ),
              SizedBox(width: 8),
              Text('mobile.viewing.mockClient'.tr(), style: GoogleFonts.outfit(color: colors.textPrimary, fontSize: 12, fontWeight: FontWeight.bold)),
              const Spacer(),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: colors.background,
                  foregroundColor: colors.textPrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), 
                    side: BorderSide(color: colors.border),
                  ),
                  minimumSize: const Size(80, 28),
                  padding: EdgeInsets.zero,
                ),
                child: Text('mobile.viewing.edit'.tr(), style: GoogleFonts.outfit(fontSize: 10, fontWeight: FontWeight.w900)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
