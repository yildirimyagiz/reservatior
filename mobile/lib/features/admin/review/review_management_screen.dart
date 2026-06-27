import 'dart:ui';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:reservatior/core/providers/admin/review_provider.dart';

class ReviewManagementScreen extends ConsumerWidget {
  const ReviewManagementScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reviewsAsync = ref.watch(adminReviewsProvider);

    return Scaffold(
      backgroundColor: AppColors.darkBg,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 140,
            pinned: true,
            backgroundColor: AppColors.darkBg.withValues(alpha: 0.8),
            flexibleSpace: ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: FlexibleSpaceBar(
                  centerTitle: false,
                  titlePadding:  EdgeInsets.only(left: 24, bottom: 20),
                  title: Text(
                    'mobile.admin.review.title'.tr(),
                    style: GoogleFonts.outfit(
                      fontWeight: FontWeight.w800,
                      fontSize: 22,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
          reviewsAsync.when(
            loading: () =>  SliverFillRemaining(
              child: Center(
                child: CircularProgressIndicator(color: AppColors.gold),
              ),
            ),
            error: (err, stack) => SliverFillRemaining(
              child: Center(
                child: Text(
                  'mobile.admin.review.error_loading'.tr(),
                  style: const TextStyle(color: Colors.redAccent),
                ),
              ),
            ),
            data: (reviews) {
              if (reviews.isEmpty) {
                return SliverFillRemaining(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                         Icon(
                          Icons.star_border,
                          color: Colors.white24,
                          size: 64,
                        ),
                         SizedBox(height: 16),
                        Text(
                          'mobile.admin.review.empty'.tr(),
                          style: GoogleFonts.outfit(
                            color: Colors.white54,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }

              final flaggedCount = reviews.where((r) => !r.isVerified).length;
              final avgRating =
                  reviews.fold<double>(0, (sum, item) => sum + item.rating) /
                  reviews.length;

              return SliverMainAxisGroup(
                slivers: [
                  SliverPadding(
                    padding: const EdgeInsets.all(16),
                    sliver: SliverToBoxAdapter(
                      child: Row(
                        children: [
                          _buildStatCard(
                            'Avg Rating',
                            avgRating.toStringAsFixed(1),
                            Icons.star,
                            AppColors.gold,
                          ),
                          const SizedBox(width: 16),
                          _buildStatCard(
                            'Flagged',
                            flaggedCount.toString(),
                            Icons.flag_rounded,
                            Colors.redAccent,
                          ),
                        ],
                      ).animate().fadeIn().slideY(begin: 0.1),
                    ),
                  ),
                  SliverPadding(
                    padding:  EdgeInsets.symmetric(horizontal: 16),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        final review = reviews[index];
                        final isFlagged = !review.isVerified;

                        return Container(
                              margin:  EdgeInsets.only(bottom: 12),
                              decoration: BoxDecoration(
                                color: isFlagged
                                    ? Colors.redAccent.withValues(alpha: 0.05)
                                    : Colors.white.withValues(alpha: 0.03),
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: isFlagged
                                      ? Colors.redAccent.withValues(alpha: 0.3)
                                      : Colors.white.withValues(alpha: 0.05),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.person_outline,
                                              color: Colors.white54,
                                              size: 18,
                                            ),
                                            const SizedBox(width: 8),
                                            Text(
                                              review.reviewerId,
                                              style: GoogleFonts.outfit(
                                                fontWeight: FontWeight.w600,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.star,
                                              color: AppColors.gold,
                                              size: 16,
                                            ),
                                            const SizedBox(width: 4),
                                            Text(
                                              review.rating.toStringAsFixed(1),
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                     SizedBox(height: 12),
                                    Text(
                                      review.targetType,
                                      style: TextStyle(
                                        color: AppColors.gold.withValues(
                                          alpha: 0.8,
                                        ),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      '"\${review.comment ?? '
                                      '}"',
                                      style: const TextStyle(
                                        color: Colors.white70,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                    if (isFlagged) ...[
                                       SizedBox(height: 16),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          TextButton.icon(
                                            onPressed: () {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text('admin.common.coming_soon'.tr()),
      backgroundColor: Colors.orange,
    ),
  );
},
                                            icon:  Icon(
                                              Icons.check,
                                              color: Colors.green,
                                            ),
                                            label: Text('admin.common.approve'.tr(),
                                              style: TextStyle(
                                                color: Colors.green,
                                              ),
                                            ),
                                          ),
                                          TextButton.icon(
                                            onPressed: () {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text('admin.common.coming_soon'.tr()),
      backgroundColor: Colors.orange,
    ),
  );
},
                                            icon:  Icon(
                                              Icons.delete_outline,
                                              color: Colors.redAccent,
                                            ),
                                            label: Text('admin.common.remove'.tr(),
                                              style: TextStyle(
                                                color: Colors.redAccent,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                            )
                            .animate()
                            .fadeIn(delay: Duration(milliseconds: 100 * index))
                            .slideX();
                      }, childCount: reviews.length),
                    ),
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: 100)),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Expanded(
      child: Container(
        padding:  EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withValues(alpha: 0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 12),
            Text(
              value,
              style: GoogleFonts.outfit(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              title,
              style: GoogleFonts.outfit(color: Colors.white54, fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }
}
