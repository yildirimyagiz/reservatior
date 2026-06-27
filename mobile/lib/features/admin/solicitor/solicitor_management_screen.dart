import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:reservatior/core/providers/admin/solicitor_management_provider.dart';

class SolicitorManagementScreen extends ConsumerWidget {
  const SolicitorManagementScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final solicitorsAsync = ref.watch(adminSolicitorsProvider);

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
                    'mobile.admin.solicitor.title'.tr(),
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
          solicitorsAsync.when(
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
            data: (solicitors) {
              if (solicitors.isEmpty) {
                return  SliverFillRemaining(
                  child: Center(
                    child: Text('admin.common.no_solicitors'.tr(),
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
                    final sol = solicitors[index];
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
                            contentPadding: const EdgeInsets.all(16),
                            leading: const Icon(
                              Icons.gavel,
                              color: Colors.deepPurpleAccent,
                              size: 32,
                            ),
                            title: Text(
                              sol.solicitorType,
                              style: GoogleFonts.outfit(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                 SizedBox(height: 4),
                                Text('admin.common.fee_prefix'.tr() +
                                      (sol.fee?.toString() ?? 'N/A') +
                                      ' ' +
                                      (sol.currency ?? ''),
                                  style: TextStyle(color: Colors.white70),
                                ),
                                 SizedBox(height: 4),
                                Text('admin.common.created_prefix'.tr() +
                                      sol.createdAt.toLocal().toString().split(
                                        ' ',
                                      )[0],
                                  style: const TextStyle(
                                    color: Colors.white38,
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
                                color: Colors.pinkAccent.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                sol.status.toUpperCase(),
                                style: const TextStyle(
                                  color: Colors.pinkAccent,
                                  fontSize: 11,
                                ),
                              ),
                            ),
                          ),
                        )
                        .animate()
                        .fadeIn(delay: Duration(milliseconds: 50 * index))
                        .slideX();
                  }, childCount: solicitors.length),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
