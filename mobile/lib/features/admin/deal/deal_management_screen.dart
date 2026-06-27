import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:reservatior/core/providers/admin/deal_provider.dart';

class DealManagementScreen extends ConsumerWidget {
  const DealManagementScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dealsAsync = ref.watch(adminDealsProvider);

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
                    'mobile.admin.deal.title'.tr(),
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
          dealsAsync.when(
            loading: () =>  SliverFillRemaining(
              child: Center(
                child: CircularProgressIndicator(color: AppColors.gold),
              ),
            ),
            error: (err, stack) => SliverFillRemaining(
              child: Center(
                child: Text('admin.common.error_prefix'.tr() + err.toString(),
                  style:  TextStyle(color: Colors.redAccent),
                ),
              ),
            ),
            data: (deals) {
              if (deals.isEmpty) {
                return  SliverFillRemaining(
                  child: Center(
                    child: Text('admin.common.no_deals'.tr(),
                      style: TextStyle(color: Colors.white54),
                    ),
                  ),
                );
              }
              return SliverPadding(
                padding:  EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final deal = deals[index];
                    return Container(
                          margin:  EdgeInsets.only(bottom: 12),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.03),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.05),
                            ),
                          ),
                          child: ListTile(
                            contentPadding:  EdgeInsets.all(16),
                            leading: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.lightGreenAccent.withValues(
                                  alpha: 0.2,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(
                                Icons.monetization_on,
                                color: Colors.lightGreenAccent,
                              ),
                            ),
                            title: Text(
                              deal.dealType ?? 'Unknown Deal',
                              style: GoogleFonts.outfit(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                 SizedBox(height: 4),
                                Text('admin.common.offer_prefix'.tr() +
                                      (deal.offerPrice?.toString() ?? 'N/A'),
                                  style: TextStyle(color: Colors.white70),
                                ),
                                 SizedBox(height: 4),
                                Text('admin.common.sale_prefix'.tr() +
                                      (deal.salePrice?.toString() ?? 'N/A'),
                                  style: const TextStyle(
                                    color: Colors.greenAccent,
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                            trailing: Container(
                              padding:  EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.cyanAccent.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                deal.dealStatus.name.toUpperCase(),
                                style: const TextStyle(
                                  color: Colors.cyanAccent,
                                  fontSize: 11,
                                ),
                              ),
                            ),
                          ),
                        )
                        .animate()
                        .fadeIn(delay: Duration(milliseconds: 50 * index))
                        .slideX();
                  }, childCount: deals.length),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
